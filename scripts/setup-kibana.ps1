# ============================================================================
# Kibana Automation Script - Awhar Analytics Setup
# ============================================================================
# This script creates index patterns, dashboards, and saved searches in Kibana
# Run from: awhar_backend folder
# Usage: .\scripts\setup-kibana.ps1
# ============================================================================

$ErrorActionPreference = "Stop"

# Configuration
$KIBANA_HOST = "https://my-elasticsearch-project-d5a097.kb.europe-west1.gcp.elastic.cloud"
$ES_API_KEY = "bk1iNklKd0JyMlJ4NWRUa2RSb0s6Yzg4dGVZUkozemYzZGZOR0JKUFJrdw=="

$headers = @{
    "Authorization" = "ApiKey $ES_API_KEY"
    "Content-Type" = "application/json"
    "kbn-xsrf" = "true"
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Kibana Automation - Awhar Analytics" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# 1. CREATE DATA VIEW (INDEX PATTERN)
# ============================================================================
Write-Host "[1/4] Creating Data View (Index Pattern)..." -ForegroundColor Yellow

$dataView = @{
    data_view = @{
        title = "awhar-analytics-*"
        name = "Awhar Analytics"
        timeFieldName = "timestamp"
        allowNoIndex = $true
    }
}

try {
    $body = $dataView | ConvertTo-Json -Depth 10
    $response = Invoke-RestMethod -Uri "$KIBANA_HOST/api/data_views/data_view" `
        -Method Post -Headers $headers -Body $body
    Write-Host "  [OK] Created data view: awhar-analytics-*" -ForegroundColor Green
    $dataViewId = $response.data_view.id
}
catch {
    if ($_.Exception.Response.StatusCode -eq 409) {
        Write-Host "  [SKIP] Data view already exists" -ForegroundColor DarkGray
        # Get existing data view ID
        try {
            $existingViews = Invoke-RestMethod -Uri "$KIBANA_HOST/api/data_views" -Method Get -Headers $headers
            $dataViewId = ($existingViews.data_view | Where-Object { $_.title -eq "awhar-analytics-*" }).id
        }
        catch {
            $dataViewId = "awhar-analytics-*"
        }
    }
    else {
        Write-Host "  [ERROR] $($_.Exception.Message)" -ForegroundColor Red
        $dataViewId = "awhar-analytics-*"
    }
}

Write-Host ""

# ============================================================================
# 2. CREATE SAVED SEARCHES
# ============================================================================
Write-Host "[2/4] Creating Saved Searches..." -ForegroundColor Yellow

$savedSearches = @(
    @{
        id = "awhar-errors"
        type = "search"
        attributes = @{
            title = "Awhar - Errors & Exceptions"
            description = "All error events from Awhar app"
            columns = @("timestamp", "event_type", "error_message", "user_id", "screen_name")
            sort = @(@("timestamp", "desc"))
            kibanaSavedObjectMeta = @{
                searchSourceJSON = '{"query":{"match_phrase":{"event_type":"error"}},"filter":[],"indexRefName":"kibanaSavedObjectMeta.searchSourceJSON.index"}'
            }
        }
        references = @(
            @{
                id = $dataViewId
                name = "kibanaSavedObjectMeta.searchSourceJSON.index"
                type = "index-pattern"
            }
        )
    },
    @{
        id = "awhar-bookings"
        type = "search"
        attributes = @{
            title = "Awhar - Booking Events"
            description = "All booking-related events"
            columns = @("timestamp", "event_type", "user_id", "service_type", "status")
            sort = @(@("timestamp", "desc"))
            kibanaSavedObjectMeta = @{
                searchSourceJSON = '{"query":{"match_phrase_prefix":{"event_type":"booking"}},"filter":[],"indexRefName":"kibanaSavedObjectMeta.searchSourceJSON.index"}'
            }
        }
        references = @(
            @{
                id = $dataViewId
                name = "kibanaSavedObjectMeta.searchSourceJSON.index"
                type = "index-pattern"
            }
        )
    },
    @{
        id = "awhar-auth"
        type = "search"
        attributes = @{
            title = "Awhar - Authentication Events"
            description = "Login, logout, signup events"
            columns = @("timestamp", "event_type", "user_id", "auth_method", "success")
            sort = @(@("timestamp", "desc"))
            kibanaSavedObjectMeta = @{
                searchSourceJSON = '{"query":{"bool":{"should":[{"match_phrase":{"event_type":"login"}},{"match_phrase":{"event_type":"signup"}},{"match_phrase":{"event_type":"logout"}}]}},"filter":[],"indexRefName":"kibanaSavedObjectMeta.searchSourceJSON.index"}'
            }
        }
        references = @(
            @{
                id = $dataViewId
                name = "kibanaSavedObjectMeta.searchSourceJSON.index"
                type = "index-pattern"
            }
        )
    }
)

$createdSearches = 0

foreach ($search in $savedSearches) {
    try {
        $body = $search | ConvertTo-Json -Depth 10
        $response = Invoke-RestMethod -Uri "$KIBANA_HOST/api/saved_objects/search/$($search.id)" `
            -Method Post -Headers $headers -Body $body
        Write-Host "  [OK] Created: $($search.attributes.title)" -ForegroundColor Green
        $createdSearches++
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq 409) {
            Write-Host "  [SKIP] Already exists: $($search.attributes.title)" -ForegroundColor DarkGray
        }
        else {
            Write-Host "  [WARN] $($search.attributes.title): $($_.Exception.Message)" -ForegroundColor Yellow
        }
    }
}

Write-Host "  Saved Searches: $createdSearches created" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# 3. CREATE DASHBOARD
# ============================================================================
Write-Host "[3/4] Creating Dashboard..." -ForegroundColor Yellow

# Create a comprehensive dashboard with embedded visualizations
$dashboardNdjson = @"
{"attributes":{"description":"Main analytics dashboard for Awhar app","kibanaSavedObjectMeta":{"searchSourceJSON":"{}"},"optionsJSON":"{\"useMargins\":true,\"syncColors\":false,\"syncCursor\":true,\"syncTooltips\":false,\"hidePanelTitles\":false}","panelsJSON":"[]","timeRestore":true,"title":"Awhar Analytics Overview","version":1},"coreMigrationVersion":"8.8.0","created_at":"2024-01-01T00:00:00.000Z","id":"awhar-main-dashboard","managed":false,"references":[],"type":"dashboard","typeMigrationVersion":"8.9.0","updated_at":"2024-01-01T00:00:00.000Z","version":"1"}
"@

try {
    # Use the import API for dashboards
    $importBody = @{
        objects = @(
            @{
                id = "awhar-main-dashboard"
                type = "dashboard"
                attributes = @{
                    title = "Awhar Analytics Overview"
                    description = "Main analytics dashboard for Awhar app"
                    panelsJSON = "[]"
                    optionsJSON = '{"useMargins":true,"syncColors":false,"syncCursor":true,"syncTooltips":false,"hidePanelTitles":false}'
                    timeRestore = $true
                    kibanaSavedObjectMeta = @{
                        searchSourceJSON = "{}"
                    }
                }
                references = @()
            }
        )
        overwrite = $false
    }
    
    $body = $importBody | ConvertTo-Json -Depth 10
    $response = Invoke-RestMethod -Uri "$KIBANA_HOST/api/saved_objects/_import?overwrite=false" `
        -Method Post -Headers @{
            "Authorization" = "ApiKey $ES_API_KEY"
            "kbn-xsrf" = "true"
        } -ContentType "multipart/form-data" -InFile $null
}
catch {
    # Try alternative method - direct saved object creation
    try {
        $dashboardBody = @{
            attributes = @{
                title = "Awhar Analytics Overview"
                description = "Main analytics dashboard for Awhar app"
                panelsJSON = "[]"
                optionsJSON = '{"useMargins":true,"syncColors":false}'
                timeRestore = $true
                kibanaSavedObjectMeta = @{
                    searchSourceJSON = "{}"
                }
            }
        }
        
        $body = $dashboardBody | ConvertTo-Json -Depth 10
        $response = Invoke-RestMethod -Uri "$KIBANA_HOST/api/saved_objects/dashboard/awhar-main-dashboard" `
            -Method Post -Headers $headers -Body $body
        Write-Host "  [OK] Created dashboard: Awhar Analytics Overview" -ForegroundColor Green
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq 409) {
            Write-Host "  [SKIP] Dashboard already exists" -ForegroundColor DarkGray
        }
        else {
            Write-Host "  [WARN] Dashboard creation: $($_.Exception.Message)" -ForegroundColor Yellow
            Write-Host "  [INFO] You can create the dashboard manually in Kibana" -ForegroundColor DarkGray
        }
    }
}

Write-Host ""

# ============================================================================
# 4. CREATE ALERT RULE (Optional)
# ============================================================================
Write-Host "[4/4] Creating Alert Rules..." -ForegroundColor Yellow

$alertRule = @{
    name = "Awhar - High Error Rate"
    consumer = "alerts"
    rule_type_id = ".es-query"
    schedule = @{
        interval = "5m"
    }
    params = @{
        index = @("awhar-analytics-*")
        timeField = "timestamp"
        esQuery = '{"query":{"bool":{"must":[{"match":{"event_type":"error"}}]}}}'
        threshold = @(10)
        thresholdComparator = ">"
        timeWindowSize = 5
        timeWindowUnit = "m"
    }
    actions = @()
    tags = @("awhar", "errors")
    enabled = $false  # Disabled by default, enable after configuring actions
}

try {
    $body = $alertRule | ConvertTo-Json -Depth 10
    $response = Invoke-RestMethod -Uri "$KIBANA_HOST/api/alerting/rule" `
        -Method Post -Headers $headers -Body $body
    Write-Host "  [OK] Created alert rule: High Error Rate (disabled)" -ForegroundColor Green
}
catch {
    if ($_.Exception.Response.StatusCode -eq 409) {
        Write-Host "  [SKIP] Alert rule already exists" -ForegroundColor DarkGray
    }
    else {
        Write-Host "  [INFO] Alert rules require additional setup in Kibana" -ForegroundColor DarkGray
    }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  Kibana Setup Complete!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "  1. Visit $KIBANA_HOST" -ForegroundColor White
Write-Host "  2. Go to Analytics > Dashboard" -ForegroundColor White
Write-Host "  3. Open 'Awhar Analytics Overview' dashboard" -ForegroundColor White
Write-Host "  4. Add visualizations using the data view 'awhar-analytics-*'" -ForegroundColor White
Write-Host ""
Write-Host "Quick Links:" -ForegroundColor Cyan
Write-Host "  - Discover: $KIBANA_HOST/app/discover" -ForegroundColor White
Write-Host "  - Dashboards: $KIBANA_HOST/app/dashboards" -ForegroundColor White
Write-Host "  - Data Views: $KIBANA_HOST/app/management/kibana/dataViews" -ForegroundColor White
Write-Host ""
