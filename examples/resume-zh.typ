#import "../resume-template.typ": *

// 基础排版与主题配色配置
#let (resume-header, resume-entry) = setup-styles(
  accent-color: rgb("#2563EB"),        // 现代科技蓝
  heading-bg-color: rgb("#EDF4FC"),    // 浅蓝横幅背景
  text-color: rgb("#0F172A"),          // Slate-900 深灰黑
  body-color: rgb("#334155"),          // Slate-700 正文
  meta-color: rgb("#64748B"),          // Slate-500 次要信息
  font-size: 9.8pt,                    // 单页高密度基准字号
  element-spaciness: 1.00,             // 紧凑度微调因子
)

#show: resume-header.with(
  author: "张 三",
  profile-image: "assets/avatar.png",
  basic-info: (
    [男 · 2027 届本科生 · 求职意向：Java 后端开发 / AI 应用开发],
  ),
  telephone: "138-0000-0000",
  email: "zhangsan@example.com",
  github-id: "zhangsan-dev",
  location: "杭州 / 上海 / 远程",
)

= 教育经历

#resume-entry(
  title: "某某重点大学",
  subtitle: "计算机科学与技术 · 工学学士",
  date: "2023.09 - 2027.06",
)[
  - *主修课程：* 数据结构与算法、计算机网络、操作系统、计算机组成原理、数据库系统原理、分布式系统
  - *学业表现：* 专业前 10%、校级一等奖学金、CET-6 (560+)
]

= 实习经历

#resume-entry(
  title: "某科技独角兽企业",
  subtitle: "后端开发实习生 · 基础服务平台部",
  date: "2026.06 - 2026.09",
)[
#strong[项目介绍：] 负责平台在线客服 IM 实时通讯系统与接入层长连接网关从零到一的研发落地。\
#strong[核心职责与落地：]
- *长连接网关与动态编排：* 基于 *Netty* 搭建高并发接入层，通过前置字节预读实现单端口 TCP 私有协议与 WebSocket 智能嗅探及 Pipeline 动态装配；在 HTTP Upgrade 阶段拦截鉴权并绑定 Channel 上下文，随后*动态卸载鉴权 Handler* 消除后续管道开销；结合空闲检测与单端互踢机制，杜绝半开假死连接与句柄泄漏。
- *会话流设计与游标分页：* 针对传统客服工单割裂与历史记录 `LIMIT offset` 深分页慢查询痛点，设计单用户连续会话模型；基于 `(sessionId, Seq)` 构建*倒序游标分页（Cursor Pagination）*，消除深分页扫描与数据漂移，历史消息漫游接口耗时由 1.2s 降至 15ms 内。
- *消息可靠投递与背压异步落库：* 设计“`clientMsgId` 幂等去重 + 双向 ACK 回执 + Redis 单调递增 `Seq`”机制，解决弱网重发导致的乱序与消息状态未知痛点；实现 Netty 网络 I/O 与持久化完全解耦，引入 *Java 21 虚拟线程 + Semaphore(200) 背压限流* 异步写库，兼顾高吞吐与 MySQL 连接池安全。
- *坐席负载调度与会话平滑转接：* 基于 Redis 实时计数实现最小负载优先分发，全忙时自动降级至 ZSet 优先级排队队列；利用数据库 CAS 乐观锁原子变更会话归属，实现*无数据迁移平滑转接*，杜绝并发抢单冲突，新坐席无缝继承完整历史上下文。
]

= 项目经历

#resume-entry(
  title: "OpenManus-Small: 轻量级自主智能体评测与运行底座",
  subtitle: "核心开发者 · 开源项目",
  date: "2026.02 - 2026.05",
)[
#strong[项目介绍：] 面向长程复杂任务自研的高性能 Agent Harness 运行时，提供状态流转、工具调用与上下文管理。\
#strong[核心技术与设计：]
- *状态机调度与任务自主纠偏：* 基于*有限状态机（FSM）*规范 ReAct 思考与执行闭环；构建重复调用指纹比对机制，命中阈值后动态注入反思提示词强制阻断死循环，结合工具输出安全截断，保障长程复杂任务的自主纠偏能力与上下文安全。
- *工具流式装配与安全执行门禁：* 针对 SSE 响应下参数碎片化痛点，设计流式装配器解耦打字机推流与参数 Schema 校验；构建集成了*三级权限控制（放行/确认/阻断）与高危命令防御的安全门禁*，拦截后动态回填错误帧引导模型自主纠偏；在伯克利函数调用评测（BFCL）Simple 任务中取得 94.0% 的准确率。
- *弹性上下文管理与超长自愈：* 针对长程会话 Token 膨胀及盲目截断破坏语义问题，提出真实 Usage 锚点结合 CJK 汉字计权的动态预算算法；实现严格对齐 User 边界的滑动增量压缩；构建上下文超长自愈机制，捕获 HTTP 400/413 异常后自动触发强制压缩与补偿重试。
- *可信会话持久化引擎：* 构建基于树形结构的 Append-only JSONL 会话持久化引擎，支持毫秒级断点恢复；设计悬空调用自愈算法，在异常重启时自动检测并回填缺失的工具执行回执，保障断点续跑时上下文的协议合规。
]

= 专业技能

- *Java 生态与核心技术：* 深入理解 Java 基础、集合体系、JUC 并发编程及 JVM 内存模型；熟练掌握 *Java 21 虚拟线程* 并发模式与性能调优；熟练使用 Spring Boot、Spring Cloud、MyBatis-Plus 等主流微服务技术栈。
- *网络编程与中间件：* 熟练掌握 *Netty* 异步网络编程框架，深入理解 Reactor 反应器模式、ChannelPipeline 生命周期管理及高性能编解码；熟练掌握 *Redis* 核心数据结构、持久化与分布式锁机制。
- *数据存储与高并发：* 熟练掌握 *MySQL* 索引底层原理（B+ 树）、事务 ACID、MVCC 隔离机制及慢 SQL 调优；熟练掌握分布式 ID 生成、游标分页、消息幂等性与流量背压控制方案。
- *大模型应用与工程能力：* 熟悉 Agentic Workflow、ReAct 范式、Function Calling / Tool Use 机制与 RAG 检索增强技术；熟悉 Linux 常用命令、Git 版本协同及 Docker 容器化部署。
