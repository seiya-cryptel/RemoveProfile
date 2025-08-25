<#
    ローカルPCのユーザープロファイル一覧を表示する
#>

# 管理者権限で実行されていなければ、管理者権限で再実行
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { 
    Start-Process powershell.exe "-ExecutionPolicy Bypass -NoProfile -File `"$PSCommandPath`"" -Verb RunAs -PassThru
}

Write-Host "ユーザープロファイルの検索を開始します..." -ForegroundColor Yellow

# 現在ログインしているユーザのプロファイル名
$CurrentUserName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name.Split('\')[-1]
Write-Host "現在のユーザー: $CurrentUserName" -ForegroundColor Green
Write-Host ""

try {
    # ローカルコンピューター上のユーザープロファイルを取得
    $UserProfiles = Get-WmiObject -Class Win32_UserProfile -Filter "Special = 'False'"

    Write-Host "見つかったユーザープロファイル一覧:" -ForegroundColor Yellow
    Write-Host "----------------------------------------" -ForegroundColor Gray
    
    foreach ($Profile in $UserProfiles) {
        $ProfileName = $Profile.LocalPath.Split('\')[-1]
        
        # 現在ログインしているプロファイルかチェック
        if ($ProfileName -eq $CurrentUserName) {
            Write-Host "★ $ProfileName (現在ログイン中)" -ForegroundColor Yellow
        } else {
            Write-Host "  $ProfileName" -ForegroundColor White
        }
    }
        
    Write-Host "----------------------------------------" -ForegroundColor Gray
} catch {
    Write-Host "エラーが発生しました: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "処理が完了しました。" -ForegroundColor Green

Write-Host "エンターキーを押すと終了します..." -ForegroundColor Cyan
Read-Host
