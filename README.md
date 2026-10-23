# Modern Typst Resume (单页工程师简历模板)

专为技术研发人员（后端、全栈、算法、Agent / AI 应用开发）设计的高信息密度、现代化、抗视觉疲劳的 Typst 单页简历模板。

---

## 效果预览

![简历预览效果](assets/preview.png)

---

## 核心设计特性

- **现代微徽章标题设计**：小节标题采用左侧垂直色块（Accent Bar）搭配全宽浅色横幅填充，替代传统生硬的横线或大黑框，层次清晰且视觉通透。
- **三级防疲劳灰度色彩系统**：
  - 一级标题 / 姓名 / 重点：深石板黑 (`#0F172A`)，告别纯黑（`#000000`）带来的刺眼疲劳感。
  - 正文内容：柔和深灰 (`#334155`)，保持高阅读辨识度。
  - 次级元信息（时间、副标题、联系方式）：中灰 (`#64748B`)，主次分明。
- **单页严丝合缝控制（Dynamic Spacing）**：提供 `element-spaciness` 全局间距缩放系数，无需繁琐调整各个容器 margin，微调参数（如 `0.95 ~ 1.05`）即可让内容严丝合缝卡在单页 A4 纸内。
- **现代化图标支持**：内置 `@preview/nerd-icons:0.2.0` 图标库，电话、邮箱、GitHub、主页等联系方式自动排版。
- **开箱即用（三体 · 罗辑示例）**：内置《三体》面壁者/执剑人罗辑的经典简历示例，极客趣味与硬核结构兼备，生动展示单页高信息密度的排版效果。

---

## 项目结构

```text
resume-template/
├── resume-template.typ    # 核心模板函数库 (setup-styles, resume-header, resume-entry)
├── examples/
│   ├── resume-zh.typ      # 单页中文示例（三体 · 罗辑）
│   ├── luoji.typ          # 同步示例镜像
│   └── resume-zh.pdf      # 编译产物 PDF
├── assets/
│   ├── avatar.png         # 罗辑头像占位图
│   └── preview.png        # 效果预览图
├── fonts/                 # 本地备用 Nerd Font 符号字体
├── LICENSE                # MIT 开源协议
└── README.md              # 说明文档
```

---

## 快速开始

### 1. 安装 Typst

Typst 是极速、现代的排版引擎：

- **macOS (Homebrew)**: `brew install typst`
- **Windows (Winget)**: `winget install --id Typst.Typst`
- **Linux / Arch**: `pacman -S typst` 或从 [GitHub Releases](https://github.com/typst/typst/releases) 下载二进制文件放入系统 PATH。

### 2. 实时预览与开发

在项目根目录下启动监听模式，保存文件后秒级热重载：

```bash
typst watch --root . --font-path ./fonts examples/resume-zh.typ
```

### 3. 导出编译为 PDF

```bash
typst compile --root . --font-path ./fonts examples/resume-zh.typ examples/resume-zh.pdf
```

---

## 配置参数速查

通过调用 `#let (resume-header, resume-entry) = setup-styles(...)` 定制全局风格：

| 参数名 | 默认值 | 说明 |
| :--- | :--- | :--- |
| `accent-color` | `rgb("#2563EB")` | 主题色（标题文字、加粗关键词、链接高亮） |
| `heading-bg-color` | `rgb("#EDF4FC")` | 标题栏横幅背景色（传入 `none` 则为透明无背景） |
| `heading-bar-color` | `auto` | 标题左侧垂直色块颜色（`auto` 自动同步 `accent-color`） |
| `text-color` | `rgb("#0F172A")` | 姓名、大标题、经历名称等一级重点文字颜色 |
| `body-color` | `rgb("#334155")` | 正文字体颜色（抗视觉疲劳深灰） |
| `meta-color` | `rgb("#64748B")` | 副标题、时间日期、联系方式等次要文字颜色 |
| `font-size` | `10pt` | 全局正文字号基准（推荐单页设置为 `9.5pt ~ 10.2pt`） |
| `element-spaciness` | `1.00` | 垂直紧凑度系数（如内容偏多可设为 `0.95`，偏少设为 `1.05`） |
| `heading-radius` | `0pt` | 标题左侧竖条圆角（硬朗直角设为 `0pt`，微圆角可设为 `1.5pt`） |
| `margin` | `(x: 1.2cm, y: 1.2cm)` | 页面基准边距 |

---

## 推荐配色方案

可根据个人喜好或求职岗位切换不同配色方案：

| 配色风格 | `accent-color` | `heading-bg-color` | 适用岗位 / 视觉特点 |
| :--- | :--- | :--- | :--- |
| **现代科技蓝 (默认)** | `rgb("#2563EB")` | `rgb("#EDF4FC")` | 后端开发、分布式架构、AI / Agent 工程师 |
| **经典工程蓝** | `rgb("#1E88E5")` | `rgb("#EBF3FB")` | 稳重干练、传统名企 / 国企 / 大厂通用 |
| **极简石板黑** | `rgb("#334155")` | `rgb("#F1F5F9")` | 算法研究、科研助理、极简性冷淡风 |
| **深林墨绿** | `rgb("#0F766E")` | `rgb("#F0FDFA")` | 全栈开发、数据工程、低调沉稳 |

---

## 单页排版控行技巧

在技术简历中，**严格卡在单页（不多 1 行也不空留大面积空白）** 是专业度的体现：

1. **利用 `element-spaciness` 缩放**：
   - 若出现文字溢出到第 2 页第一行：将 `element-spaciness` 设为 `0.96` 或 `0.94`；
   - 若页面底部留白过多：将 `element-spaciness` 设为 `1.04` 或 `1.06`。
2. **字号微调**：
   - 默认基准字号为 `9.8pt ~ 10pt`，必要时可在 `9.5pt` 至 `10.2pt` 之间微调。
3. **行距与段距自动自适应**：
   - 内部已将 `par(leading: ...)` 与 `par(spacing: ...)` 绑定至 `element-spaciness`，全局间距协同缩放，避免局部挤压变形。

---

## 开源协议

本项目基于 [MIT 许可证](LICENSE) 开源。欢迎 Star、Fork 与二次定制！
