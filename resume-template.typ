#import "@preview/nerd-icons:0.2.0": nf-icon

#let setup-styles(
  // 配色方案（支持默认或自定义）
  accent-color: rgb("#2563EB"),        // 主色调（标题文字、强调高亮、链接）
  heading-bg-color: rgb("#EDF4FC"),    // 标题横幅背景色（设为 none 则不显示背景）
  heading-bar-color: auto,             // 标题左侧垂直色块颜色（auto 则跟随 accent-color）
  text-color: rgb("#0F172A"),          // 主文字颜色（深灰黑 Slate-900，避免纯黑视觉疲劳）
  body-color: rgb("#334155"),          // 正文文字颜色（Slate-700）
  meta-color: rgb("#64748B"),          // 次要信息颜色（副标题、时间、联系方式 Slate-500）
  background-color: rgb("#ffffff"),    // 页面背景色
  
  // 字体配置
  sans-serif-font: ("Noto Sans SC", "Source Han Sans SC", "PingFang SC", "Microsoft YaHei", "SimHei"),
  serif-font: ("Noto Serif SC", "Source Han Serif SC", "Songti SC", "SimSun"),
  alt-font: ("Noto Sans SC", "Source Han Sans SC", "PingFang SC", "Microsoft YaHei"),
  
  // 排版控制
  font-size: 10pt,                     // 基准字号
  element-spaciness: 1.00,             // 垂直间距缩放系数（0.9 ~ 1.1 动态控行）
  margin: (x: 1.2cm, y: 1.2cm),        // 页边距基准
  separator: " · ",                    // 信息分隔符
  heading-radius: 0pt,                 // 标题左侧色块圆角
) = {
  let bar-color = if heading-bar-color == auto { accent-color } else { heading-bar-color }

  let resume-header(
    author: "",
    profile-image: "",
    basic-info: (),
    telephone: "",
    email: "",
    wechat-id: "",
    github-id: "",
    blog-link: "",
    location: "",
    body,
  ) = {
    set document(
      author: author, 
      title: author + " - 个人简历", 
      date: datetime.today()
    )

    // 页面与基础文本排版
    set page(
      paper: "a4",
      margin: (
        x: margin.x * element-spaciness,
        y: margin.y * element-spaciness,
      ),
      fill: background-color,
    )
    
    set par(
      justify: true,
      leading: 0.52em * element-spaciness,
      spacing: 0.85em * element-spaciness,
    )

    set text(
      font: (
        (name: "New Computer Modern", covers: regex("•")),
        sans-serif-font,
      ).flatten(),
      lang: "zh",
      size: font-size,
      fill: body-color,
      ligatures: false,
    )

    // 链接与文字强调规范
    show link: it => {
      set text(fill: accent-color)
      underline(it)
    }
    show strong: it => text(fill: text-color, weight: "bold", it.body)
    show emph: it => text(fill: text-color, style: "italic", it.body)

    // 小节标题样式：带左侧垂直微色块与横幅浅色背景
    show heading: it => {
      block(
        width: 100%,
        fill: heading-bg-color,
        inset: (x: 0.35em, y: 0.32em),
        above: 0.85em * element-spaciness,
        below: 0.55em * element-spaciness,
        {
          // 1. 左侧垂直色块
          box(
            rect(
              fill: bar-color,
              width: 3.5pt,
              height: 1.1em,
              radius: heading-radius,
            ),
            baseline: 15%,
          )
          // 2. 色块与标题文字间距
          h(0.45em)
          // 3. 标题文字
          text(
            font: sans-serif-font,
            weight: "bold",
            size: 1.05em,
            fill: accent-color,
            it.body,
          )
        }
      )
    }

    // 组装联系方式
    let contacts = ()
    if telephone != "" {
      contacts.push([#nf-icon("nf-md-phone_in_talk") #h(0.2em) #telephone])
    }
    if email != "" {
      contacts.push([#nf-icon("nf-fa-envelope") #h(0.2em) #link("mailto:" + email)[#email]])
    }
    if wechat-id != "" {
      contacts.push([#nf-icon("nf-fa-wechat") #h(0.2em) #wechat-id])
    }
    if github-id != "" {
      contacts.push([#nf-icon("nf-md-github") #h(0.2em) #link("https://github.com/" + github-id)[github.com/#github-id]])
    }
    if blog-link != "" {
      contacts.push([#nf-icon("nf-fa-globe") #h(0.2em) #link(blog-link)[#blog-link]])
    }
    if location != "" {
      contacts.push([#nf-icon("nf-fa-location_dot") #h(0.2em) #location])
    }

    // 渲染右上角头像（若未提供则全宽排版）
    if profile-image != "" {
      let header-height = 3.2em + 2.0em * element-spaciness
      if basic-info.len() > 0 {
        header-height += 1.1em + 0.4em * element-spaciness
      }
      place(
        top + right,
        dx: -0.2em,
        image(
          profile-image, 
          height: header-height, 
          width: auto, 
          fit: "contain"
        )
      )
    }

    // 头部信息块（姓名、基础信息、联系方式）
    block(
      width: 100%,
      inset: (bottom: 0.2em * element-spaciness),
      {
        text(font: sans-serif-font, weight: 800, size: 2.1em, fill: text-color, author)
        linebreak()
        v(0.25em * element-spaciness)
        if basic-info.len() > 0 {
          text(fill: meta-color, basic-info.join(separator))
          linebreak()
          v(0.15em * element-spaciness)
        }
        text(fill: meta-color, size: 0.95em, contacts.join(separator))
      }
    )
    
    body
  }

  let resume-entry(
    title: "经历事项",
    subtitle: "",
    date: "",
    body
  ) = {
    // 条目首行（主标题 + 副标题 + 时间）
    text(font: sans-serif-font, weight: "bold", fill: text-color, title)
    if subtitle != "" {
      text(font: alt-font, fill: meta-color, separator + subtitle)
    }
    if date != "" {
      h(1fr)
      text(font: alt-font, fill: meta-color, date)
    }
    
    // 条目详细内容列表
    if (body != []) {
      linebreak()
      v(-0.35em * element-spaciness)
      block(
        width: 100%,
        inset: (x: 0.2em, y: 0.1em),
        body
      )
    }
  }

  (
    resume-header: resume-header,
    resume-entry: resume-entry,
  )
}
