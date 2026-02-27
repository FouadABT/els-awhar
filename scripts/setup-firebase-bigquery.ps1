# ============================================================================
# Firebase BigQuery Export Setup Script
# ============================================================================
# This script helps set up BigQuery export for Firebase Analytics
# Prerequisites: gcloud CLI installed and authenticated
# Usage: .\scripts\setup-firebase-bigquery.ps1
# ============================================================================

$ErrorActionPreference = "Stop"

# Configuration
$FIREBASE_PROJECT_ID = "awhar-5afc5"
$BIGQUERY_DATASET = "analytics_events"
$BIGQUERY_LOCATION = "EU"  # or "US" depending on your preference

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Firebase BigQuery Export Setup" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Check if gcloud is installed
Write-Host "[1/4] Checking gcloud CLI..." -ForegroundColor Yellow
try {
    $gcloudVersion = gcloud --version 2>&1 | Select-Object -First 1
    Write-Host "  [OK] gcloud CLI found: $gcloudVersion" -ForegroundColor Green
}
catch {
    Write-Host "  [ERROR] gcloud CLI not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Google Cloud CLI:" -ForegroundColor Yellow
    Write-Host "  https://cloud.google.com/sdk/docs/install" -ForegroundColor White
    Write-Host ""
    Write-Host "After installation, run:" -ForegroundColor Yellow
    Write-Host "  gcloud auth login" -ForegroundColor White
    Write-Host "  gcloud config set project $FIREBASE_PROJECT_ID" -ForegroundColor White
    exit 1
}

Write-Host ""

# Set the project
Write-Host "[2/4] Setting project..." -ForegroundColor Yellow
try {
    gcloud config set project $FIREBASE_PROJECT_ID 2>&1 | Out-Null
    Write-Host "  [OK] Project set to: $FIREBASE_PROJECT_ID" -ForegroundColor Green
}
catch {
    Write-Host "  [ERROR] Could not set project: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Enable BigQuery API (you mentioned this is already done)
Write-Host "[3/4] Verifying BigQuery API..." -ForegroundColor Yellow
try {
    $services = gcloud services list --enabled --filter="name:bigquery.googleapis.com" --format="value(name)" 2>&1
    if ($services -like "*bigquery*") {
        Write-Host "  [OK] BigQuery API is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "  [INFO] Enabling BigQuery API..." -ForegroundColor Yellow
        gcloud services enable bigquery.googleapis.com 2>&1 | Out-Null
        Write-Host "  [OK] BigQuery API enabled" -ForegroundColor Green
    }
}
catch {
    Write-Host "  [WARN] Could not verify BigQuery API: $($_.Exception.Message)" -ForegroundColor Yellow
}

Write-Host ""

# Create BigQuery dataset
Write-Host "[4/4] Creating BigQuery dataset..." -ForegroundColor Yellow
try {
    # Check if dataset exists
    $datasetCheck = bq ls --format=json 2>&1 | ConvertFrom-Json
    $existingDataset = $datasetCheck | Where-Object { $_.datasetReference.datasetId -eq $BIGQUERY_DATASET }
    
    if ($existingDataset) {
        Write-Host "  [SKIP] Dataset '$BIGQUERY_DATASET' already exists" -ForegroundColor DarkGray
    }
    else {
        bq mk --location=$BIGQUERY_LOCATION --dataset "${FIREBASE_PROJECT_ID}:${BIGQUERY_DATASET}" 2>&1 | Out-Null
        Write-Host "  [OK] Created dataset: $BIGQUERY_DATASET" -ForegroundColor Green
    }
}
catch {
    Write-Host "  [INFO] Dataset may already exist or requires manual creation" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  BigQuery Setup Complete!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "IMPORTANT: Complete the following steps manually in Firebase Console:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Go to Firebase Console:" -ForegroundColor Cyan
Write-Host "   https://console.firebase.google.com/project/$FIREBASE_PROJECT_ID/settings/integrations" -ForegroundColor White
Write-Host ""
Write-Host "2. Click 'BigQuery' in the integrations list" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. Click 'Link' to connect Firebase Analytics to BigQuery" -ForegroundColor Cyan
Write-Host ""
Write-Host "4. Select these options:" -ForegroundColor Cyan
Write-Host "   - [x] Export Google Analytics events (daily)" -ForegroundColor White
Write-Host "   - [x] Export Crashlytics data" -ForegroundColor White
Write-Host "   - [x] Export Cloud Messaging data (optional)" -ForegroundColor White
Write-Host ""
Write-Host "5. Choose export location: $BIGQUERY_LOCATION" -ForegroundColor Cyan
Write-Host ""
Write-Host "After linking, data will be available in BigQuery within 24 hours." -ForegroundColor Green
Write-Host ""
Write-Host "Query your data:" -ForegroundColor Cyan
Write-Host "  https://console.cloud.google.com/bigquery?project=$FIREBASE_PROJECT_ID" -ForegroundColor White
Write-Host ""
Write-Host "Sample query:" -ForegroundColor Cyan
Write-Host @"
  SELECT
    event_name,
    COUNT(*) as count
  FROM `$FIREBASE_PROJECT_ID.analytics_*.events_*`
  WHERE _TABLE_SUFFIX >= FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY))
  GROUP BY event_name
  ORDER BY count DESC
  LIMIT 20
"@ -ForegroundColor White
Write-Host ""
