<#
.SYNOPSIS
    不要なユーザープロファイルを削除するスクリプトです。

.DESCRIPTION
    このスクリプトは、指定された除外リストに含まれないユーザープロファイルを削除します。
    管理者権限で実行する必要があります。
    現在ログインしているユーザーや重要なシステムアカウントは自動的に除外されます。

.NOTES
    作成者: seiya@cryptel.co.jp
    作成日: 2025年8月25日
    バージョン: 1.0
    必要な権限: 管理者権限

.EXAMPLE
    PS> .\RemoveProfile.ps1
    管理者権限でスクリプトを実行し、不要なユーザープロファイルを削除します。
    バッチファイルからの実行が推奨されます。

.INPUTS
    なし。このスクリプトはパラメータを受け取りません。

.OUTPUTS
    System.String
    削除処理の結果をコンソールに出力します。

.LINK
    Get-WmiObject
    
.COMPONENT
    ユーザープロファイル管理

.ROLE
    システム管理者

.FUNCTIONALITY
    ユーザープロファイルのクリーンアップ
#>

# 管理者権限で実行されていなければ、管理者権限で再実行
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { 
    Start-Process powershell.exe "-ExecutionPolicy Bypass -NoProfile -File `"$PSCommandPath`"" -Verb RunAs -PassThru
}

# 削除対象から除外するユーザープロファイルを定義します。
# 通常は、Administrator, Public, Default, Guest などを含めます。
$ExclusionList = @(
    "Administrator"
    "Public"
    "Default"
    "DefaultAccount"
    "Guest"
    "TEMP" # 一時プロファイル
    "localadmin"    # 川崎市住宅供給公社
)

# 現在ログインしているユーザのプロファイル名
$CurrentUserName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name.Split('\')[-1]
Write-Host "現在のユーザー: $CurrentUserName" -ForegroundColor Green
Write-Host ""

Write-Host "不要なユーザープロファイルの検索を開始します..." -ForegroundColor Yellow

try {
    # ローカルコンピューター上のユーザープロファイルを取得
    $UserProfiles = Get-WmiObject -Class Win32_UserProfile -Filter "Special = 'False'"

    foreach ($Profile in $UserProfiles) {
        # プロファイルのlocalPathの最後の部分（ユーザー名）を取得
        $ProfileName = $Profile.LocalPath.Split('\')[-1]

        # ユーザー名が $ を含んでいたらスキップする
        if ($ProfileName -like "*$*") {
            Write-Host "スキップ: $ProfileName" -ForegroundColor Yellow
            continue
        }

        # ログインユーザ名と同じだったらスキップする
        if ($ProfileName -eq $CurrentUserName) {
            Write-Host "スキップ: $ProfileName (現在ログイン中)" -ForegroundColor Yellow
            continue
        }

        # 除外リストに含まれているかを確認
        if ($ExclusionList -notcontains $ProfileName) {
            Write-Host "削除対象のプロファイルが見つかりました: $($Profile.LocalPath)" -ForegroundColor Cyan
            $FoundProfilesToDelete = $true

            # ユーザープロファイルを削除
            Write-Host "プロファイルを削除中... $($Profile.LocalPath)" -ForegroundColor Cyan
            # $Profile.Delete()
            
            # 削除が成功したことを確認
            <#
            if (-not (Get-WmiObject -Class Win32_UserProfile -Filter "LocalPath = '$($Profile.LocalPath)'")) {
                Write-Host "プロファイル '$($Profile.LocalPath)' は正常に削除されました。" -ForegroundColor Green
            } else {
                Write-Host "プロファイル '$($Profile.LocalPath)' の削除に失敗しました。" -ForegroundColor Red
            }
            #>
        }
    }

} catch {
    Write-Host "エラーが発生しました: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "スクリプトの実行が完了しました。" -ForegroundColor Yellow
Read-Host "エンターキーを押すと終了します..."
