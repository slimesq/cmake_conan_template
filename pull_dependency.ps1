# 拉取Conan包的脚本
param (
    [string]$BuildType = "Debug"  
)

# 检查Conan是否安装
if (-not (Get-Command conan -ErrorAction SilentlyContinue)) {
    Write-Error "Conan is not installed  or not in PATH. Please install Conan first."
    exit 1
}

# 规范化传入的构建类型（首字母大写，其余小写）
$NormalizedBuildType = $BuildType.Substring(0, 1).ToUpper() + $BuildType.Substring(1).ToLower()

# 确保构建类型合法
if ($NormalizedBuildType -notin @("Debug", "Release")) {
    Write-Error "Invalid build type: $BuildType. Please specify 'Debug' or 'Release' (case insensitive)."
    exit 1
}

# 打印当前选择的构建类型
Write-Host "Selected build type: $NormalizedBuildType"

# Conan profile
# 替换为实际使用的Conan profile名称，如果未设置则注释掉以下两行
$ConanProfile = "msvc_2022_x64_" + $NormalizedBuildType
Write-Host "Using Conan profile: $ConanProfile"

# 拉取依赖
try {
    Write-Host "Installing Conan packages..."
    conan install . `
        --build=missing `
        -pr:b="./conan_profile/"$ConanProfile `
        -pr:h="./conan_profile/"$ConanProfile `
        --output-folder=build
    Write-Host "Conan packages installed successfully."
}
catch {
    Write-Error "Failed to install Conan packages: $_"
    exit 1
}

# 成功提示
Write-Host "Conan install completed for build type: $NormalizedBuildType"