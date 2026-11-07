$ErrorActionPreference = 'Stop'
Push-Location (Split-Path -Parent $PSScriptRoot)
try {
    flutter clean
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    flutter pub get
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    flutter analyze
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    flutter test
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    $buildStarted = Get-Date
    # Chọn một kiến trúc để Flutter phân tích được kích thước AOT.
    flutter build apk --release --target-platform android-arm64 --analyze-size --code-size-directory reports/size
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    New-Item -ItemType Directory -Path 'release' -Force | Out-Null
    Copy-Item -LiteralPath 'build/app/outputs/flutter-apk/app-release.apk' -Destination 'release/app-arm64-release.apk'
    # Flutter có thể đặt báo cáo tổng hợp ở .flutter-devtools trong user profile.
    # Sao chép đúng file vừa tạo vào project để dễ xem và nộp bài.
    $analysisFolder = Join-Path ([Environment]::GetFolderPath('UserProfile')) '.flutter-devtools'
    if (Test-Path -LiteralPath $analysisFolder) {
        $analysis = Get-ChildItem -LiteralPath $analysisFolder -Filter 'apk-code-size-analysis*.json' |
            Where-Object { $_.LastWriteTime -ge $buildStarted } |
            Sort-Object LastWriteTime -Descending | Select-Object -First 1
        if ($analysis) { Copy-Item -LiteralPath $analysis.FullName -Destination 'reports/size/apk-code-size-analysis.json' }
    }
    Write-Output 'APK: release/app-arm64-release.apk'
    Write-Output 'Phân tích: dart devtools --appSizeBase=reports/size/apk-code-size-analysis.json'
    Write-Output 'Bản học tập ký debug; phát hành store cần upload key/signing riêng.'
} finally { Pop-Location }
