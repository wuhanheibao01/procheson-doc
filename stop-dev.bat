@echo off
title 停止PLC ST测试报告开发服务器
echo 正在停止VitePress开发服务器...
taskkill /f /im node.exe /fi "WINDOWTITLE eq PLC ST测试报告开发服务器*"
echo VitePress开发服务器已停止
pause