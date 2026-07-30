@echo off
if "%YYTARGET_runtime%"=="VM" (
    exit 0
) 

echo GX YYC Fix %GMEXT_GX_YYC_FIX_VERSION% - Packaging...
setlocal enabledelayedexpansion

cd %YYprojectDir%
powershell -command "Expand-Archive -Path '%YYtargetFile%' -DestinationPath '%YYoutputFolder%\GX_YYC_FIX_Output' -Force"

del "%YYoutputFolder%\GX_YYC_FIX_Output\runner-sw.js"

set ProjectName=%YYprojectName%

set ProjectName=%ProjectName: =_%
set ProjectName=%ProjectName:-=_%

echo const g_pWadLoadCallback = function () {};const loadGame=()=^>{let e=document.createElement(^"script^");e.src=^"%ProjectName%.js^",e.async=!0,document.head.appendChild(e)},loadSW=async()=^>{try{await navigator.serviceWorker.register(^"sw.js^"),await navigator.serviceWorker.ready,loadGame()}catch(e){console.error(e),loadGame()}};^"serviceWorker^"in navigator^&^&window.addEventListener(^"load^",loadSW); > "%YYoutputFolder%\GX_YYC_FIX_Output\runner-sw.js"
	
powershell -command "Compress-Archive  -Update -Path '%YYoutputFolder%\GX_YYC_FIX_Output\*' -DestinationPath '%YYtargetFile%'"
# rmdir "%YYoutputFolder%\GX_YYC_FIX_Output\"