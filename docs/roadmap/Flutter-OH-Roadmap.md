# 2026 Flutter-OH 路线图：共筑鸿蒙生态

> **文档入口**：[README 路线图章节](../../README.md#flutter-oh-roadmap) · [OH 开发文档索引](https://gitcode.com/openharmony-tpc/flutter_samples/blob/master/README.md)

为了提高透明度，我们希望分享我们路线图的细节，以便开发者能够了解我们的优先事项，并根据我们正在进行的工作制定计划。

这份路线图旨在分享 Flutter 在 OpenHarmony 生态（Flutter-OH）当前的重点投入领域与未来一年的主要方向。内容主要来自技术研发团队与 [Flutter SIG](https://gitcode.com/OpenHarmony-CrossPlatformFramework/community/blob/main/sigs/sig-flutter/charter.md) 成员的共同讨论。请注意，此路线图仅为意向声明，并非承诺或完整的功能列表。实际交付内容可能会根据技术挑战、社区反馈和资源情况而调整。我们鼓励开发者通过 Flutter SIG 社区参与讨论，共同塑造 Flutter 在鸿蒙生态的未来。

------

## 版本迭代：加速与上游同步

官方源社区在[3.41发布公告](https://blog.flutter.dev/whats-new-in-flutter-3-41-302ec140e632)上将2026年4个版本计划也同步公布了。2026 年，我们会加快迭代，按季度发布 Flutter-OH 版本，力争将同步源社区的滞后时间从 2025 年的平均 7 个月左右缩短至 **4 个月左右**，让开发者更快体验到 Flutter 官方的新特性和问题修复，三端一致Flutter版本不再是瓶颈，具体计划如下：

| Flutter 版本 | 源社区发布时间 | 鸿蒙版本发布时间 | 间隔时间 |
| :----------- | :------------- | :--------------- | -------- |
| Flutter 3.35 | 2025/08        | 2026/03          | 7个月    |
| Flutter 3.41 | 2026/02        | 2026/06          | 4个月    |
| Flutter 3.44 | 2026/05        | 2026/09          | 4个月    |
| Flutter 3.47 | 2026/08        | 2026/12          | 4个月    |

*注：以上时间为预估，实际发版可能会根据质量验收情况及交付规划微调。*

------

##  内存性能与负载：2026年重点投入优化

根据 2025 年底的内部基准测试，Flutter-OH 在内存方面与其他系统的表现仍有一些差距，负载差距则更为明显。2026 年除合入[Flutter源社区](https://github.com/flutter/flutter)外，我们将重点投入以下优化：

### 内存优化

- **DMA 内存后台释放**：优化图形缓冲区管理，在应用切换至后台时主动释放 [DMA](https://zh.wikipedia.org/wiki/直接内存访问) 内存，降低系统内存压力。
- **图片解码时按需缩放**：在图片解码阶段直接执行 `resize` 操作，避免加载超尺寸大图，减少内存峰值。
- **预加载缓存Buffer动态调整优化**：平衡内存与性能，调整 Flutter 引擎的预加载 Buffer 数量。

### 负载优化

- **动画冗余绘制消除**：消除Flutter后台动画绘制，减少不必要的engine空跑，降低 CPU/GPU 负载。
- **Raster线程零脏区渲染优化**：在帧渲染流程中，通过精确的脏区域检测机制，若当前帧与上一帧相比无任何更新区域（即零脏区域），则直接复用上一帧的渲染缓冲区

### 性能专项

- **毕昇编译优化**：利用华为毕昇编译器的深度优化能力，提升指令执行效率。

*注：26年实际落地方案不限于如上所列，也欢迎更多开发贡献自己的优化思路与方案*

------

## 可定位能力增强：让问题无处遁形

基于过去一年的源声梳理和能力分析，为提升开发者的调试和定位效率，2026 年我们将大幅增强 Flutter-OH 的内存泄漏和部分性能的定位能力：

- **性能定位效率提升**：补齐关键点的Hilog和trace日志
- **内存剖析工具链**：对接鸿蒙 hiTrace 和 hiProfiler，提供 Flutter内存占用的细粒度分析视图。

------

## 特色功能：打造鸿蒙生态的长板

我们致力于让 Flutter 在鸿蒙设备上拥有独特的体验优势，2026 年将重点落地以下特性：

- **平行视界支持**：为折叠屏、平板等大屏设备提供“[平行视界](https://developer.huawei.com/consumer/cn/doc/HMSCore-Guides/introduction-0000001051507626)”能力，开发者通过少量配置即可实现同一应用内左右双窗口展示，充分利用大屏空间。我们将提供详细的迁移指南和示例代码，帮助现有 Flutter 应用快速适配。

---

## 能力补齐：体验和能力不断补齐

- **广色域（P3）显示**：在支持 [DCI-P3 色域](https://zh.wikipedia.org/wiki/DCI-P3) 的鸿蒙设备上，Flutter 应用将获得更丰富的色彩表现，提升图像、视频等内容的视觉沉浸感。该特性将兼容现有 sRGB 内容。
- **密码自动填充服务**：在Flutter上支持与鸿蒙原生体验一致的[密码保险箱功能](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/passwordvault-overview)，在登录、注册等场景带来更好的体验。

------

##  三方库丰富：双路径补齐生态

Flutter 的强大离不开丰富的三方库生态。大量Flutter三方库不需要兼容适配HarmomyOS系统，不兼容三方库当前已完成适配三百余个，见[清单](https://gitcode.com/openharmony-tpc/flutter_packages),也有不少开源开发者参与适配贡献。

2026 年，我们规划了 **至少 200 个高优先级 Flutter 三方库的鸿蒙适配**（更多适配计划还在规划中），覆盖网络、数据库、图片处理、音视频、地图等常见领域。主要通过如下渠道来持续丰富三方库

- **三方库自规划**：根据三方库使用频度和技术域等，按优先级分批适配，并定期公布适配清单。
- **开发者驱动**：开发者可通过[开发者联盟工单系统](https://developer.huawei.com/consumer/cn/support/feedback/#/ticketCard)提交库适配需求，我们会高优先级进行评估并排期。
- **社区共建**：与Flutter SIG成员、高校、开源爱好者合作，共同丰富和繁荣Flutter在鸿蒙系统上的三方库
- **Flutter 三方库鸿蒙化 Skills**：我们将围绕鸿蒙原生能力与 Flutter 插件开发展开技能沉淀，输出可复用、可组合的插件鸿蒙化 Skill 集合。此举有望降低开发者参与鸿蒙适配的门槛，激发社区共建热情，加速 Flutter 插件在鸿蒙生态中的高质量落地。
------

## 持续开源与生态治理

我们坚信开源是技术长存的基础。2026 年，Flutter-OH 将持续在 OpenHarmony 社区开源运作，并通过以下方式增强项目健康度：

- **Flutter SIG 常态化运作**：自 2025 年 1 月成立以来，Flutter SIG 已成为版本规划、技术共建的核心阵地。今年我们将定期举办 SIG 月度例会，分享技术、同步进展、收集需求，并邀请社区 Maintainer 参与决策。
- **[CI/CD](https://zh.wikipedia.org/wiki/CI/CD) 基础设施升级**：当前已支持编译构建、静态扫描、开源合规检查等能力。2026 年将重点建设自动化测试能力，包括：
  - **冒烟测试**：日构建版本，自动运行核心场景冒烟用例，确保基础功能可用，提前发现概率问题。
  - **自动化DT测试**：每次代码提交在主流鸿蒙设备上运行DT用例，提升基础质量。
- **社区文档与示例**：完善开发文档、迁移指南和最佳实践，降低新开发者上手门槛。

------

## 结语与号召

Flutter-OH 的成长离不开每一位开发者的参与。无论您是贡献代码、提交 Issue、分享经验，还是在 SIG 中提出建议，都是对项目的重要推动。让我们共同努力，让 Flutter 成为鸿蒙生态中最强大、最易用的跨平台开发框架。

**需求与交流**

- 问题反馈：欢迎在[Flutter框架仓库](https://gitcode.com/openharmony-tpc/flutter_flutter/issues)及各个Flutter三方库提交issues
- 需求反馈：无论是框架功能还是三方库适配，欢迎你在[issues](https://gitcode.com/openharmony-tpc/flutter_flutter/issues)或者[开发者联盟工单](https://developer.huawei.com/consumer/cn/support/feedback/#/ticketCard)提交需求，方便我们第一时间进行分析与需求排序

**加入我们：**

- 我们欢迎更多的开发者和开源伙伴加入我们，如果您有兴趣，可以通过[OpenHarmony Flutter SIG 主页](https://gitcode.com/OpenHarmony-CrossPlatformFramework/community/blob/main/sigs/sig-flutter/charter.md)的联系方式联系我们。