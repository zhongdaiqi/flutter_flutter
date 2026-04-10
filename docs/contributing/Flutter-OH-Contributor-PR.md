# Flutter_OH仓库代码合入流程

## 概述

本文档描述了在 Flutter-OH仓库进行代码贡献与合入的流程。

---

## 一、安装 Git
完成Git环境配置，该步骤请自行参考网上教程完成。

## 二、签署 DCO 协议

DCO（Developer Certificate of Origin，开发者原创声明）用于声明你提交的代码是你本人所做或你有权利提交。

请访问以下链接完成签署：

**[https://dco.openharmony.cn/sign](https://dco.openharmony.cn/sign)**

> 点击页面上的 **「签署DCO」** 按钮，使用 Gitcode 账号授权并完成签署即可。签署为一次性操作，完成后后续提交无需重复签署。

---
## 三、Fork 仓库到个人项目

将Flutter-OH的仓库Fork到个人项目下，便于独立开发完成后基于个人私仓发起 PR合入请求到Flutter-OH公仓。

### 操作步骤

1. 打开目标仓库页面，如 `https://gitcode.com/<org>/<repo>`
2. 点击右上角 **「Fork」** 按钮
3. 选择 Fork 到自己的账号，点击 **「确认 Fork」**
4. Fork 完成后，在自己账号下可以看到 `https://gitcode.com/<your-name>/<repo>`

---

## 四、Clone 仓库到本地

将Fork到个人项目下的仓库克隆到本地进行开发。

```bash
# 使用 SSH 方式克隆（推荐）
git clone git@gitcode.com:<your-name>/<repo>.git

# 进入项目目录
cd <repo>

# 查看远端配置
git remote -v
```

> 克隆后默认只有 `origin`（指向自己的 Fork 仓库），建议同时添加 `upstream` 指向原始仓库。

```bash
# 添加上游仓库（upstream）
git remote add upstream git@gitcode.com:<org>/<repo>.git
```

---

## 五、提交到私仓
### 提交到本地仓库（git commit）
```bash
# 提交并且同时进行Signed-off-by签名操作
#可参链接：https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/FAQ.md
git commit -s -m "feat: 新增 xxx 功能"
```
> 签署DCO是必须的，否则无法通过仓库流水线检查；
若是修复问题，提交信息以`Fix:`开头，若是新增特性，以`Feat:` 开头。

### 推送到远端（git push）

```bash
# 推送当前分支到自己的 Fork 仓库
git push origin feature/<your-feature-name>
```

---

## 六、新建 Issue、PR

### 新建 Issue

Issue 用于反馈 Bug、提出需求或进行讨论，每个PR在运行流水线和合入前必须关联一个Issue，建议在发起 PR 前，先创建对应的 Issue。

1. 进入**Flutter-OH的原始仓库**页面（非 Fork到个人项目的私仓）
2. 点击 **「Issues」** → **「新建 Issue」**
3. 选择合适的 Issue 模板（如 Bug Report、Feature Request）
4. 填写标题和详细描述，点击 **「提交」**

> 记录下 Issue 编号（如 `#42`），后续在 PR 中关联使用。

### 新建 Pull Request（PR）

1. 推送分支后，进入Fork到个人项目的私仓页面
2. GitCode 会自动提示 **「为此分支创建 Pull Request」**，点击即可；或手动点击 **「Pull Request」** → **「新建 Pull Request」**
3. 确认：
   - **源仓库/分支**：`<your-name>/<repo>` 的 `feature/<your-feature-name>`
   - **目标仓库/分支**：`<org>/<repo>` 的 `main`
4. 填写 PR 信息（见第七节规范）
5. 点击 **「创建 Pull Request」**

---

## 七、PR 提交规范

规范的PR提交方便更快速地合入仓库，请遵循以下规范：

1. 代码中所有注释、Commit提交信息、PR标题、内容描述等均使用英文。
2. Commit代码时，若是修复问题，提交信息以`Fix:`开头，若是新增特性，以`Feat:` 开头，清晰描述代码变化点。
3. 创建PR时选择默认的PR描述模板，PR描述内容填写完整，完整的信息方便评审人员检视代码快速完成合入流程。

---

## 八、获取代码检视及审查

1. 在PR右侧的右侧指定评审人员后，评审人员会及时处理并提出检视意见，处理完检视意见后可在评论中@对应的评审人请求确认，评审人员确认所有检视意见并点击**“已解决”**，点击**“代码评审待通过”**通过。
2. 在PR右侧的右侧指定审查人员后，审查人员确认该PR所有前置条件都已通过，对当前 PR 提交的代码进行质量评估、逻辑检查、风格规范和文档注释的审核，确保代码质量，无问题则可点击“代码审查”通过（如有问题，也可继续提意见）。

---

## 九、PR 合入要求

PR 需满足以下全部条件，方可由 openharmony_ci 自动执行合入：

| 条件 | 要求 |
|--------|------|
| 代码门禁通过 | 在PR的评论区评论`start build`触发流水线门禁执行，门禁内容包括dco检查、编译检查、静态检查，确保右侧的**测试人**显示**已通过**标签 |
| 代码评审通过 | 在PR右侧的**评审人**至少指定一人进行评审且评审通过，显示**已通过**标签（点击⚙️可以选择评审人）                         |
| 代码审查通过 | 在PR右侧的**审查人**指定两人进行审查且审查通过，显示**已通过**标签（点击⚙️可以选择审查人）                           |
| 检视意见已解决 | 确认PR中的所有代码检视意见都已处理，并点击**“已解决”**                                               |

> 代码门禁常见错误处理：
> 1. 评论`start build`后提示“此PR未通过DCO校验”，可能是“未签署“DCO协议”或者“Commits 中未包含 Signed-off-by信息”，参考对应提示的指引进行处理即可。
> 2. 如果代码门禁未通过，可在评论页看到查看相关报错进行处理后再重新提交代码。对于**“静态检查”**的`result`是`noPass`的情况，可以点击`report`下的链接查看具体报错问题，如是不需要解决的报错可在评论区@任一审查人员屏蔽报错，审查人员屏蔽完成以后，PR提交人重新评论`start build`触发门禁。对于**“编译测试”**的`build result`不是`success`的情况，，可以点击`build result`下的链接查看日志找到失败原因。
> 

如果代码检视、审查等环节处理不及时，可在PR评论中@对应人员进行处理，如果仍长时间未响应，可邮件发送至huanglin23@huawei.com、zhuhaojian@huawei-partners.com请求处理。