[CmdletBinding()]
param(
    [string]$Project,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$repoUrl = 'https://github.com/gmreyescdev/gemini-design-harness.git'
$zipUrl = 'https://github.com/gmreyescdev/gemini-design-harness/archive/refs/heads/main.zip'

$kit = $PSScriptRoot
$kitAgents = $null
if (-not [string]::IsNullOrWhiteSpace($kit)) {
    $kitAgents = Join-Path $kit 'AGENTS.md'
}

if ([string]::IsNullOrWhiteSpace($kit) -or -not (Test-Path -LiteralPath $kitAgents)) {
    $currentAgents = Join-Path (Get-Location).Path 'AGENTS.md'
    if (Test-Path -LiteralPath $currentAgents) {
        $kit = (Get-Location).Path
    } else {
        Write-Host "Descargando Gemini Design Harness desde GitHub..." -ForegroundColor Cyan
        $zip = Join-Path $env:TEMP 'gemini-design-harness.zip'
        $tmp = Join-Path $env:TEMP 'gemini-design-harness-main'

        Invoke-WebRequest -Uri $zipUrl -OutFile $zip -UseBasicParsing
        if (Test-Path -LiteralPath $tmp) {
            Remove-Item -LiteralPath $tmp -Recurse -Force
        }
        Expand-Archive -Path $zip -DestinationPath $env:TEMP -Force
        $kit = $tmp
    }
}

$kitAgents = Join-Path $kit 'AGENTS.md'
if (-not (Test-Path -LiteralPath $kitAgents)) {
    throw "No se encontro AGENTS.md en la ruta del kit: $kit. Revisa tu conexion o clona el repositorio manualmente."
}

Write-Host ""
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "   Gemini Design Harness - Instalador v1.0     " -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

if ([string]::IsNullOrWhiteSpace($Project)) {
    $desktop = [Environment]::GetFolderPath('Desktop')
    $default = Join-Path $desktop 'mi-proyecto-gemini'
    $Project = Read-Host "Carpeta destino de tu proyecto (Enter para usar $default)"
    if ([string]::IsNullOrWhiteSpace($Project)) {
        $Project = $default
    }
}

$Project = $Project.Trim().Trim('"')
if (-not (Test-Path -LiteralPath $Project)) {
    New-Item -ItemType Directory -Path $Project -Force | Out-Null
    Write-Host "[+] Carpeta de proyecto creada: $Project" -ForegroundColor Cyan
}
$Project = (Resolve-Path -LiteralPath $Project).Path

# 1. Copiar AGENTS.md en la raiz
$agentsPath = Join-Path $Project 'AGENTS.md'
if ((Test-Path -LiteralPath $agentsPath) -and (-not $Force)) {
    $answer = Read-Host "Ya existe AGENTS.md en el proyecto. Sobrescribir? (s/N)"
    if ($answer -notmatch '^(s|si|y|yes)$') {
        Write-Host "Instalacion cancelada por el usuario. No se modifico nada." -ForegroundColor Yellow
        exit 1
    }
}

Copy-Item -LiteralPath (Join-Path $kit 'AGENTS.md') -Destination $agentsPath -Force
Write-Host "[OK] AGENTS.md copiado en la raiz del proyecto." -ForegroundColor Green

# 2. Copiar documentacion y protocolo en docs/harness
$docs = Join-Path $Project 'docs\harness'
New-Item -ItemType Directory -Path $docs -Force | Out-Null

$files = @(
    'README.md',
    'HARNESS.md',
    'MODEL-NOTES.md',
    'SUBAGENTS.md',
    'COST.md',
    'SKILLS.md',
    'KICKOFF.md',
    'QUESTION-BANK.md',
    'CHANGELOG.md',
    'ROADMAP.md'
)

foreach ($file in $files) {
    $source = Join-Path $kit $file
    if (Test-Path -LiteralPath $source) {
        Copy-Item -LiteralPath $source -Destination (Join-Path $docs $file) -Force
    }
}

foreach ($dir in @('templates', 'state', 'checklists')) {
    $sourceDir = Join-Path $kit $dir
    if (Test-Path -LiteralPath $sourceDir) {
        Copy-Item -LiteralPath $sourceDir -Destination $docs -Recurse -Force
    }
}
Write-Host "[OK] Protocolo, plantillas, estados y checklists copiados en docs/harness." -ForegroundColor Green

# 3. Copiar skills a .gemini/skills y .opencode/skills (para compatibilidad total)
$skillsSource = Join-Path $kit 'skills'
if (Test-Path -LiteralPath $skillsSource) {
    $realSkills = @(Get-ChildItem -LiteralPath $skillsSource -Directory | Where-Object { $_.Name -notlike '_*' })
    if ($realSkills.Count -gt 0) {
        $geminiSkillsTarget = Join-Path $Project '.gemini\skills'
        $opencodeSkillsTarget = Join-Path $Project '.opencode\skills'
        $destTargets = @($geminiSkillsTarget, $opencodeSkillsTarget)
        foreach ($target in $destTargets) {
            New-Item -ItemType Directory -Path $target -Force | Out-Null
            foreach ($skill in $realSkills) {
                Copy-Item -LiteralPath $skill.FullName -Destination (Join-Path $target $skill.Name) -Recurse -Force
            }
        }
        Write-Host "[OK] Skills integradas instaladas en .gemini/skills/ y .opencode/skills/." -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Green
Write-Host "  Instalacion completada con exito!                       " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Proximos pasos:" -ForegroundColor Cyan
Write-Host "1. Abre tu entorno de codificacion (Antigravity / IDE) en:" -ForegroundColor White
Write-Host "   $Project" -ForegroundColor Yellow
Write-Host "2. Pega este mensaje en el chat con Gemini:" -ForegroundColor White
Write-Host '   Inicia el Gemini Design Harness en modo Express. Hazme la Ronda 1.' -ForegroundColor Green
Write-Host ""
