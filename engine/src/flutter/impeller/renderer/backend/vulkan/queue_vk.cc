// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "impeller/renderer/backend/vulkan/queue_vk.h"

#include <utility>

#include "impeller/renderer/backend/vulkan/context_vk.h"

#ifdef FML_OS_OHOS
// The vendored Vulkan-Hpp headers ship without the OHOS platform extension
// declarations, so the entry point is spelled out locally. Signature matches
// the OHOS spec: (queue, semaphore count, semaphores, image, fence fd out).
using PFNVkQueueSignalReleaseImageOHOS =
    VkResult (*)(VkQueue queue,
                 uint32_t semaphore_count,
                 const VkSemaphore* p_semaphores,
                 VkImage image,
                 int* p_fence_fd);
#endif

namespace impeller {

QueueVK::QueueVK(QueueIndexVK index, vk::Queue queue, vk::Device device)
    : index_(index), queue_(queue), device_(device) {}

QueueVK::~QueueVK() = default;

const QueueIndexVK& QueueVK::GetIndex() const {
  return index_;
}

vk::Result QueueVK::Submit(const vk::SubmitInfo& submit_info,
                           const vk::Fence& fence) const {
  Lock lock(queue_mutex_);
  return queue_.submit(submit_info, fence);
}

vk::Result QueueVK::Submit(const vk::Fence& fence) const {
  Lock lock(queue_mutex_);
  return queue_.submit({}, fence);
}

vk::Result QueueVK::Present(const vk::PresentInfoKHR& present_info) {
  Lock lock(queue_mutex_);
  return queue_.presentKHR(present_info);
}

void QueueVK::WaitIdle() const {
  Lock lock(queue_mutex_);
  [[maybe_unused]] auto result = queue_.waitIdle();
  return;
}

void QueueVK::InsertDebugMarker(std::string_view label) const {
  if (!HasValidationLayers()) {
    return;
  }
  vk::DebugUtilsLabelEXT label_info;
  label_info.pLabelName = label.data();
  Lock lock(queue_mutex_);
  queue_.insertDebugUtilsLabelEXT(label_info);
}

#ifdef FML_OS_OHOS
vk::Result QueueVK::QueueSignalReleaseImageOHOS(
    std::vector<vk::Semaphore> semaphores,
    vk::Image image,
    int* fence_fd) {
  Lock lock(queue_mutex_);
  // The vendored Vulkan-Hpp wrapper predates the OHOS platform extensions,
  // so vkQueueSignalReleaseImageOHOS is resolved dynamically off the device
  // dispatch table (same pattern as the VMA proc table in allocator_vk.cc).
  auto fn = reinterpret_cast<PFNVkQueueSignalReleaseImageOHOS>(
      VULKAN_HPP_DEFAULT_DISPATCHER.vkGetDeviceProcAddr(
          static_cast<VkDevice>(device_), "vkQueueSignalReleaseImageOHOS"));
  if (fn == nullptr) {
    return vk::Result::eErrorExtensionNotPresent;
  }
  std::vector<VkSemaphore> raw_semaphores;
  raw_semaphores.reserve(semaphores.size());
  for (const auto& semaphore : semaphores) {
    raw_semaphores.push_back(static_cast<VkSemaphore>(semaphore));
  }
  auto result = reinterpret_cast<PFNVkQueueSignalReleaseImageOHOS>(fn)(
      static_cast<VkQueue>(queue_), static_cast<uint32_t>(raw_semaphores.size()),
      raw_semaphores.data(), static_cast<VkImage>(image), fence_fd);
  return static_cast<vk::Result>(result);
}
#endif

QueuesVK::QueuesVK() = default;

QueuesVK::QueuesVK(std::shared_ptr<QueueVK> graphics_queue,
                   std::shared_ptr<QueueVK> compute_queue,
                   std::shared_ptr<QueueVK> transfer_queue)
    : graphics_queue(std::move(graphics_queue)),
      compute_queue(std::move(compute_queue)),
      transfer_queue(std::move(transfer_queue)) {}

// static
QueuesVK QueuesVK::FromEmbedderQueue(vk::Queue queue,
                                     uint32_t queue_family_index) {
  auto graphics_queue = std::make_shared<QueueVK>(
      QueueIndexVK{.family = queue_family_index, .index = 0}, queue);

  return QueuesVK(graphics_queue, graphics_queue, graphics_queue);
}

// static
QueuesVK QueuesVK::FromQueueIndices(const vk::Device& device,
                                    QueueIndexVK graphics,
                                    QueueIndexVK compute,
                                    QueueIndexVK transfer) {
  auto vk_graphics = device.getQueue(graphics.family, graphics.index);
  auto vk_compute = device.getQueue(compute.family, compute.index);
  auto vk_transfer = device.getQueue(transfer.family, transfer.index);

  // Always set up the graphics queue.
  auto graphics_queue =
      std::make_shared<QueueVK>(graphics, vk_graphics, device);
  ContextVK::SetDebugName(device, vk_graphics, "ImpellerGraphicsQ");

  // Setup the compute queue if its different from the graphics queue.
  std::shared_ptr<QueueVK> compute_queue;
  if (compute == graphics) {
    compute_queue = graphics_queue;
  } else {
    compute_queue = std::make_shared<QueueVK>(compute, vk_compute, device);
    ContextVK::SetDebugName(device, vk_compute, "ImpellerComputeQ");
  }

  // Setup the transfer queue if its different from the graphics or compute
  // queues.
  std::shared_ptr<QueueVK> transfer_queue;
  if (transfer == graphics) {
    transfer_queue = graphics_queue;
  } else if (transfer == compute) {
    transfer_queue = compute_queue;
  } else {
    transfer_queue = std::make_shared<QueueVK>(transfer, vk_transfer, device);
    ContextVK::SetDebugName(device, vk_transfer, "ImpellerTransferQ");
  }

  return QueuesVK(std::move(graphics_queue), std::move(compute_queue),
                  std::move(transfer_queue));
}

bool QueuesVK::IsValid() const {
  return graphics_queue && compute_queue && transfer_queue;
}

}  // namespace impeller
