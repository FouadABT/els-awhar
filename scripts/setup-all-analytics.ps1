# ============================================================================
# Master Analytics Setup Script - Awhar
# ============================================================================
# This script runs all analytics platform setup scripts
# Run from: awhar_backend folder
# Usage: .\scripts\setup-all-analytics.ps1
# ============================================================================

$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "============================================================" -ForegroundColor Magenta
Write-Host "     AWHAR ANALYTICS - AUTOMATED SETUP" -ForegroundColor Magenta
Write-Host "============================================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "This script will configure:" -ForegroundColor White
Write-Host "  1. PostHog - Feature flags, cohorts, dashboards" -ForegroundColor Cyan
Write-Host "  2. Kibana - Data views, saved searches, dashboard" -ForegroundColor Cyan
Write-Host "  3. Firebase - BigQuery export setup (partial)" -ForegroundColor Cyan
Write-Host ""
Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray

$scriptDir = $PSScriptRoot
if (-not $scriptDir) {
    $scriptDir = "c:\Users\fabat\Desktop\Awhar\modernapp\v1\awhar_backend\scripts"
}

# ============================================================================
# 1. POSTHOG SETUP
# ============================================================================
Write-Host ""
Write-Host ">>> POSTHOG SETUP" -ForegroundColor Magenta
Write-Host ""

try {
    & "$scriptDir\setup-posthog.ps1"
}
catch {
    Write-Host "[ERROR] PostHog setup failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray

# ============================================================================
# 2. KIBANA SETUP
# ============================================================================
Write-Host ""
Write-Host ">>> KIBANA SETUP" -ForegroundColor Magenta
Write-Host ""

try {
    & "$scriptDir\setup-kibana.ps1"
}
catch {
    Write-Host "[ERROR] Kibana setup failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray

# ============================================================================
# 3. FIREBASE BIGQUERY SETUP
# ============================================================================
Write-Host ""
Write-Host ">>> FIREBASE BIGQUERY SETUP" -ForegroundColor Magenta
Write-Host ""

$runFirebase = Read-Host "Do you want to run Firebase BigQuery setup? (requires gcloud CLI) [y/N]"
if ($runFirebase -eq "y" -or $runFirebase -eq "Y") {
    try {
        & "$scriptDir\setup-firebase-bigquery.ps1"
    }
    catch {
        Write-Host "[ERROR] Firebase setup failed: $($_.Exception.Message)" -ForegroundColor Red
    }
}
else {
    Write-Host "  [SKIP] Firebase BigQuery setup skipped" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "     AWHAR ANALYTICS SETUP COMPLETE!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  - PostHog: Feature flags, cohorts, and dashboards created" -ForegroundColor White
Write-Host "  - Kibana: Data view and saved searches configured" -ForegroundColor White
Write-Host "  - Firebase: BigQuery export ready (manual linking required)" -ForegroundColor White
Write-Host ""
Write-Host "Quick Links:" -ForegroundColor Cyan
Write-Host "  - PostHog: https://us.posthog.com/project/304885" -ForegroundColor White
Write-Host "  - Kibana: https://my-elasticsearch-project-d5a097.kb.europe-west1.gcp.elastic.cloud" -ForegroundColor White
Write-Host "  - Firebase: https://console.firebase.google.com/project/awhar-5afc5" -ForegroundColor White
Write-Host ""
