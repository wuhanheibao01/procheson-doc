@echo off
title PLC ST测试报告开发服务器
cd /d "C:\Users\Administrator\source\repos\Procheson-doc"
start /b pnpm docs:dev > vitepress.log 2>&1
echo VitePress开发服务器已在后台启动
echo 日志已保存到 vitepress.log 文件
echo 按任意键退出此窗口（服务器将继续运行）
pause >nul