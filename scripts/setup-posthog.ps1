# ============================================================================
# PostHog Automation Script - Awhar Analytics Setup
# ============================================================================
# This script creates feature flags, cohorts, and dashboards in PostHog
# Run from: awhar_backend folder
# Usage: .\scripts\setup-posthog.ps1
# ============================================================================

$ErrorActionPreference = "Stop"

# Configuration
$POSTHOG_HOST = "https://us.posthog.com"
$POSTHOG_PROJECT_ID = "304885"
$POSTHOG_PERSONAL_API_KEY = "phx_rY719dtklhhhpPhq6ciBiUst5WydVGhbVq7M0hJE5VmsUHJ"

$headers = @{
    "Authorization" = "Bearer $POSTHOG_PERSONAL_API_KEY"
    "Content-Type" = "application/json"
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  PostHog Automation - Awhar Analytics" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# 1. CREATE FEATURE FLAGS
# ============================================================================
Write-Host "[1/3] Creating Feature Flags..." -ForegroundColor Yellow

$featureFlags = @(
    @{
        key = "new_booking_flow"
        name = "New Booking Flow"
        description = "Enable the redesigned booking experience with improved UX"
        filters = @{
            groups = @(
                @{
                    properties = @()
                    rollout_percentage = 0
                }
            )
        }
        active = $true
    },
    @{
        key = "driver_ratings_v2"
        name = "Driver Ratings V2"
        description = "Enhanced driver rating system with detailed feedback categories"
        filters = @{
            groups = @(
                @{
                    properties = @()
                    rollout_percentage = 0
                }
            )
        }
        active = $true
    },
    @{
        key = "instant_booking"
        name = "Instant Booking"
        description = "Allow instant booking without driver confirmation for verified users"
        filters = @{
            groups = @(
                @{
                    properties = @()
                    rollout_percentage = 0
                }
            )
        }
        active = $true
    },
    @{
        key = "chat_media_enabled"
        name = "Chat Media Enabled"
        description = "Enable image, voice, and file sharing in chat"
        filters = @{
            groups = @(
                @{
                    properties = @()
                    rollout_percentage = 100
                }
            )
        }
        active = $true
    },
    @{
        key = "store_catalog_v2"
        name = "Store Catalog V2"
        description = "New store catalog with categories and search"
        filters = @{
            groups = @(
                @{
                    properties = @()
                    rollout_percentage = 0
                }
            )
        }
        active = $true
    },
    @{
        key = "premium_features"
        name = "Premium Features"
        description = "Enable premium subscription features"
        filters = @{
            groups = @(
                @{
                    properties = @()
                    rollout_percentage = 0
                }
            )
        }
        active = $true
    },
    @{
        key = "analytics_debug"
        name = "Analytics Debug"
        description = "Show analytics debug screen in settings for development"
        filters = @{
            groups = @(
                @{
                    properties = @()
                    rollout_percentage = 100
                }
            )
        }
        active = $true
    }
)

$createdFlags = 0
$skippedFlags = 0

foreach ($flag in $featureFlags) {
    try {
        $body = $flag | ConvertTo-Json -Depth 10
        $response = Invoke-RestMethod -Uri "$POSTHOG_HOST/api/projects/$POSTHOG_PROJECT_ID/feature_flags/" `
            -Method Post -Headers $headers -Body $body
        Write-Host "  [OK] Created: $($flag.key)" -ForegroundColor Green
        $createdFlags++
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq 400) {
            Write-Host "  [SKIP] Already exists: $($flag.key)" -ForegroundColor DarkGray
            $skippedFlags++
        }
        else {
            Write-Host "  [ERROR] $($flag.key): $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

Write-Host "  Feature Flags: $createdFlags created, $skippedFlags skipped" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# 2. CREATE COHORTS
# ============================================================================
Write-Host "[2/3] Creating Cohorts..." -ForegroundColor Yellow

$cohorts = @(
    @{
        name = "Power Users"
        description = "Users with 10+ completed bookings"
        groups = @(
            @{
                properties = @(
                    @{
                        key = "total_bookings"
                        type = "person"
                        value = 10
                        operator = "gte"
                    }
                )
            }
        )
    },
    @{
        name = "New Users (7 days)"
        description = "Users who signed up in the last 7 days"
        groups = @(
            @{
                properties = @(
                    @{
                        key = "first_seen"
                        type = "person"
                        value = "-7d"
                        operator = "is_date_after"
                    }
                )
            }
        )
    },
    @{
        name = "Active Drivers"
        description = "Drivers who completed a trip in the last 30 days"
        groups = @(
            @{
                properties = @(
                    @{
                        key = "user_role"
                        type = "person"
                        value = "driver"
                        operator = "exact"
                    },
                    @{
                        key = "last_trip_date"
                        type = "person"
                        value = "-30d"
                        operator = "is_date_after"
                    }
                )
            }
        )
    },
    @{
        name = "Churned Users"
        description = "Users inactive for 30+ days"
        groups = @(
            @{
                properties = @(
                    @{
                        key = "last_seen"
                        type = "person"
                        value = "-30d"
                        operator = "is_date_before"
                    }
                )
            }
        )
    }
)

$createdCohorts = 0
$skippedCohorts = 0

foreach ($cohort in $cohorts) {
    try {
        $body = $cohort | ConvertTo-Json -Depth 10
        $response = Invoke-RestMethod -Uri "$POSTHOG_HOST/api/projects/$POSTHOG_PROJECT_ID/cohorts/" `
            -Method Post -Headers $headers -Body $body
        Write-Host "  [OK] Created: $($cohort.name)" -ForegroundColor Green
        $createdCohorts++
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq 400) {
            Write-Host "  [SKIP] Already exists: $($cohort.name)" -ForegroundColor DarkGray
            $skippedCohorts++
        }
        else {
            Write-Host "  [ERROR] $($cohort.name): $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

Write-Host "  Cohorts: $createdCohorts created, $skippedCohorts skipped" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# 3. CREATE DASHBOARDS
# ============================================================================
Write-Host "[3/3] Creating Dashboards..." -ForegroundColor Yellow

$dashboards = @(
    @{
        name = "Awhar - Overview"
        description = "Main analytics dashboard with key metrics"
        pinned = $true
        tags = @("awhar", "overview")
    },
    @{
        name = "Awhar - User Acquisition"
        description = "Sign-up funnel, onboarding completion, user sources"
        pinned = $false
        tags = @("awhar", "acquisition")
    },
    @{
        name = "Awhar - Booking Funnel"
        description = "Booking flow analysis and conversion rates"
        pinned = $false
        tags = @("awhar", "bookings")
    },
    @{
        name = "Awhar - Driver Performance"
        description = "Driver metrics, ratings, and activity"
        pinned = $false
        tags = @("awhar", "drivers")
    },
    @{
        name = "Awhar - Feature Adoption"
        description = "Feature flag rollout and adoption metrics"
        pinned = $false
        tags = @("awhar", "features")
    }
)

$createdDashboards = 0
$skippedDashboards = 0

foreach ($dashboard in $dashboards) {
    try {
        $body = $dashboard | ConvertTo-Json -Depth 10
        $response = Invoke-RestMethod -Uri "$POSTHOG_HOST/api/projects/$POSTHOG_PROJECT_ID/dashboards/" `
            -Method Post -Headers $headers -Body $body
        Write-Host "  [OK] Created: $($dashboard.name)" -ForegroundColor Green
        $createdDashboards++
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq 400) {
            Write-Host "  [SKIP] Already exists: $($dashboard.name)" -ForegroundColor DarkGray
            $skippedDashboards++
        }
        else {
            Write-Host "  [ERROR] $($dashboard.name): $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

Write-Host "  Dashboards: $createdDashboards created, $skippedDashboards skipped" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# 4. ENABLE SESSION RECORDING & HEATMAPS
# ============================================================================
Write-Host "[4/4] Configuring Project Settings..." -ForegroundColor Yellow

try {
    $projectSettings = @{
        session_recording_opt_in = $true
        capture_console_log_opt_in = $true
        capture_performance_opt_in = $true
        autocapture_opt_out = $false
    }
    
    $body = $projectSettings | ConvertTo-Json -Depth 10
    $response = Invoke-RestMethod -Uri "$POSTHOG_HOST/api/projects/$POSTHOG_PROJECT_ID/" `
        -Method Patch -Headers $headers -Body $body
    Write-Host "  [OK] Session recording enabled" -ForegroundColor Green
    Write-Host "  [OK] Console log capture enabled" -ForegroundColor Green
    Write-Host "  [OK] Performance capture enabled" -ForegroundColor Green
}
catch {
    Write-Host "  [WARN] Could not update project settings: $($_.Exception.Message)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  PostHog Setup Complete!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "  1. Visit https://us.posthog.com/project/$POSTHOG_PROJECT_ID/feature_flags" -ForegroundColor White
Write-Host "  2. Adjust feature flag rollout percentages as needed" -ForegroundColor White
Write-Host "  3. Add insights/charts to your dashboards" -ForegroundColor White
Write-Host ""
