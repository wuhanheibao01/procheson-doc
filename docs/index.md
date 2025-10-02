---
layout: home

title: Procheson 新PLC平台测试报告
titleTemplate: PLC指令测试验证平台

hero:
  name: PLC 指令测试报告
  text: "Procheson 注塑机电脑"
  tagline: 全面验证PLC指令功能正确性
  image:
    src: /LubanTest/logo.png
    alt: PLC测试
  actions:
    - theme: brand
      text: 查看测试报告
      link: /preface

    - theme: sponsor
      text: 测试说明
      link: /LubanTest/

    - theme: brand
      text: 测试总结
      link: /LubanTest/5.4 项目成果汇报总结
features:
  - icon: 🧪
    title: 全面测试覆盖
    details: 覆盖位操作、比较、算术、计数器等各类PLC指令
  - icon: 📊
    title: 详细测试报告
    details: 每个指令提供详细的测试说明和验证结果
  - icon: 🛠️
    title: 标准兼容
    details: 严格遵循IEC 61131-3标准，确保Beremiz环境兼容性
  - icon: 📈
    title: 结果可视化
    details: 清晰展示测试数据、期望结果和实际结果对比

---


<confetti />

<busuanzi />



<style>
.custom-actions {
  margin: 2rem 0;
  text-align: center;
}

.action-button {
  display: inline-block;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-weight: 600;
  text-decoration: none;
  transition: all 0.3s ease;
  margin: 0 0.5rem;
}

.action-button.primary {
  background-color: var(--vp-c-brand);
  color: white;
  border: 2px solid var(--vp-c-brand);
}

.action-button.primary:hover {
  background-color: var(--vp-c-brand-dark);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

@media (max-width: 768px) {
  .custom-actions {
    margin: 1rem 0;
  }
  
  .action-button {
    display: block;
    margin: 0.5rem auto;
    width: 80%;
  }
}
</style>