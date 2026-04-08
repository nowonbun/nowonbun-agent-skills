param(
    [string]$TargetDir,
    [string]$SourceRoot,
    [string]$SkillSourceDir
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ===== 설정 =====
# 경로 예시
# - SourceRoot: 저장소 루트 경로
#   예) D:\work\nownobun-agent-skills
# - SkillSourceDir: SourceRoot 기준 스킬 원본 폴더(기본값: codex-skills)
#   예) codex-skills
# - 실제 스킬 원본 탐색 경로: <SourceRoot>\<SkillSourceDir> (루트 + 하위 폴더 포함)
# - TargetDir: .codex 디렉토리의 "상위" 루트
#   예) C:\Users\nowonbun
# - 위 예시라면 실제 복사 경로는 아래처럼 된다.
#   C:\Users\nowonbun\.codex\skills\<파일명>\SKILL.md
#   C:\Users\nowonbun\.codex\config.toml
# - TargetDir를 C:\Users\nowonbun\.codex 로 넣으면 .codex가 한 번 더 붙는다.
#   C:\Users\nowonbun\.codex\.codex\...
# $DefaultTargetDir = "D:\work\target-workspace"
# $DefaultSourceRoot = (Split-Path -Parent $PSScriptRoot)
$DefaultTargetDir = "C:\Users\nowonbun\"
$DefaultSourceRoot = "D:\work\nownobun-agent-skills"
$DefaultSkillSourceDir = "codex-skills"

if (-not $PSBoundParameters.ContainsKey("TargetDir")) {
    $TargetDir = $DefaultTargetDir
}

if (-not $PSBoundParameters.ContainsKey("SourceRoot")) {
    $SourceRoot = $DefaultSourceRoot
}

if (-not $PSBoundParameters.ContainsKey("SkillSourceDir")) {
    $SkillSourceDir = $DefaultSkillSourceDir
}

function Convert-ToForwardSlashPath {
    param([Parameter(Mandatory = $true)][string]$Path)
    return ($Path -replace "\\", "/")
}

function Test-SkillSheet {
    param([Parameter(Mandatory = $true)][string]$FilePath)

    $lines = Get-Content -LiteralPath $FilePath -Encoding UTF8
    if ($lines.Count -lt 3) {
        return $false
    }

    if ($lines[0] -notmatch '^\s*---\s*$') {
        return $false
    }

    $frontmatterEnd = -1
    for ($i = 1; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '^\s*---\s*$') {
            $frontmatterEnd = $i
            break
        }
    }

    if ($frontmatterEnd -lt 1) {
        return $false
    }

    $frontmatter = $lines[1..($frontmatterEnd - 1)]
    $hasName = $frontmatter | Where-Object { $_ -match '^\s*name\s*:\s*.+' } | Select-Object -First 1
    $hasDescription = $frontmatter | Where-Object { $_ -match '^\s*description\s*:\s*.+' } | Select-Object -First 1

    return ($null -ne $hasName -and $null -ne $hasDescription)
}

function Ensure-SkillConfig {
    param(
        [Parameter(Mandatory = $true)][string]$ConfigPath,
        [Parameter(Mandatory = $true)][string]$SkillPath
    )

    if (-not (Test-Path -LiteralPath $ConfigPath)) {
        Set-Content -LiteralPath $ConfigPath -Value "" -Encoding utf8
    }

    $config = Get-Content -LiteralPath $ConfigPath -Raw -Encoding UTF8
    $escapedPath = [regex]::Escape($SkillPath)

    if ($config -match "(?m)^\s*path\s*=\s*""$escapedPath""\s*$") {
        Write-Host "[SKIP] config.toml 등록 생략: $SkillPath"
        return
    }

    $block = @"
[[skills.config]]
path = "$SkillPath"
enabled = true
"@

    $separator = if ([string]::IsNullOrWhiteSpace($config)) { "" } elseif ($config.EndsWith("`r`n") -or $config.EndsWith("`n")) { "" } else { [Environment]::NewLine }
    Add-Content -LiteralPath $ConfigPath -Value ($separator + $block + [Environment]::NewLine) -Encoding utf8
    Write-Host "[ADD ] config.toml 등록: $SkillPath"
}

$sourceRootResolved = (Resolve-Path -LiteralPath $SourceRoot).Path

if ([System.IO.Path]::IsPathRooted($SkillSourceDir)) {
    $skillSourceRoot = (Resolve-Path -LiteralPath $SkillSourceDir).Path
}
else {
    $skillSourceRoot = Join-Path $sourceRootResolved $SkillSourceDir
}

$targetDirResolved = $TargetDir

if (-not (Test-Path -LiteralPath $skillSourceRoot)) {
    throw "스킬 원본 경로를 찾지 못했습니다. expected=$skillSourceRoot"
}

if (-not (Test-Path -LiteralPath $targetDirResolved)) {
    New-Item -ItemType Directory -Path $targetDirResolved -Force | Out-Null
}

$codexRoot = Join-Path $targetDirResolved ".codex"
$skillsRoot = Join-Path $codexRoot "skills"
$configPath = Join-Path $codexRoot "config.toml"

New-Item -ItemType Directory -Path $skillsRoot -Force | Out-Null

$skillFiles = Get-ChildItem -LiteralPath $skillSourceRoot -Recurse -File -Filter "*.md" |
    Sort-Object Name |
    Where-Object { Test-SkillSheet -FilePath $_.FullName }

if (-not $skillFiles) {
    throw "메타(name, description)가 있는 스킬 시트를 찾지 못했습니다. skillSourceRoot=$skillSourceRoot"
}

$duplicateGroups = $skillFiles |
    Group-Object { [System.IO.Path]::GetFileNameWithoutExtension($_.Name) } |
    Where-Object { $_.Count -gt 1 }

if ($duplicateGroups) {
    $lines = foreach ($g in $duplicateGroups) {
        $paths = ($g.Group | ForEach-Object { $_.FullName }) -join ", "
        "$($g.Name): $paths"
    }
    throw "중복 스킬 이름(.md 제외)이 존재합니다.`n$($lines -join [Environment]::NewLine)"
}

foreach ($file in $skillFiles) {
    $skillName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    $skillDir = Join-Path $skillsRoot $skillName
    $skillTargetPath = Join-Path $skillDir "SKILL.md"

    New-Item -ItemType Directory -Path $skillDir -Force | Out-Null
    Copy-Item -LiteralPath $file.FullName -Destination $skillTargetPath -Force
    $relativePath = $file.FullName.Substring($skillSourceRoot.Length).TrimStart('\')
    Write-Host "[COPY] $relativePath -> $skillTargetPath"

    $skillTargetPathForToml = Convert-ToForwardSlashPath -Path $skillTargetPath
    Ensure-SkillConfig -ConfigPath $configPath -SkillPath $skillTargetPathForToml
}

Write-Host ""
Write-Host "완료:"
Write-Host "- sourceRoot     : $sourceRootResolved"
Write-Host "- skillSourceRoot: $skillSourceRoot"
Write-Host "- targetDir : $targetDirResolved"
Write-Host "- config    : $configPath"
