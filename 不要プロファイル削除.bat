@echo off
:: 管理者権限でRemoveProfile.ps1を実行するバッチファイル（実行ポリシーをバイパス）
powershell -Command "& {Start-Process PowerShell -ArgumentList '-ExecutionPolicy Bypass -NoProfile -File \"%~dp0RemoveProfile.ps1\"' -Verb RunAs}"
