terraform {
  # Require Terraform version 1.0 (recommended)
  required_version = "~> 1.0"

  # Require the latest 2.x version of the New Relic provider
  required_providers {
    newrelic = {
      source = "newrelic/newrelic"
    }
  }
}

provider "newrelic" {
  account_id = 4312340                            # Your New Relic account ID
  api_key    = "NRAK-640MKG8HZBTAWPYIL8BSPTVI5J1" # Your New Relic user key
  region     = "US"                               # US or EU (defaults to US)
}

data "newrelic_entity" "bible_beasts" {
  name   = "bible_beasts" # Must be an exact match to your application name in New Relic
  domain = "APM"          # or BROWSER, INFRA, MOBILE, SYNTH, depending on your entity's domain
  type   = "APPLICATION"
}

# Set up Alert Policy in New Relic
resource "newrelic_alert_policy" "golden_signal_policy" {
  name = "Golden Signals - ${data.newrelic_entity.bible_beasts.name}"
}

# Response time alert condition
resource "newrelic_alert_condition" "response_time_web" {
  policy_id       = newrelic_alert_policy.golden_signal_policy.id
  name            = "High Response Time (Web) - ${data.newrelic_entity.bible_beasts.name}"
  type            = "apm_app_metric"
  entities        = [data.newrelic_entity.bible_beasts.application_id]
  metric          = "response_time_web"
  runbook_url     = "staging-bb-load-balancer-847918050.us-east-1.elb.amazonaws.com:3000"
  condition_scope = "application"

  term {
    duration      = 5
    operator      = "above"
    priority      = "critical"
    threshold     = "5"
    time_function = "all"
  }
}

# Low throughput alert condition
resource "newrelic_alert_condition" "throughput_web" {
  policy_id       = newrelic_alert_policy.golden_signal_policy.id
  name            = "Low Throughput (Web)"
  type            = "apm_app_metric"
  entities        = [data.newrelic_entity.bible_beasts.application_id]
  metric          = "throughput_web"
  condition_scope = "application"

  # Define a critical alert threshold that will
  # trigger after 5 minutes below 5 requests per minute.
  term {
    priority      = "critical"
    duration      = 5
    operator      = "below"
    threshold     = "5"
    time_function = "all"
  }
}

# Error percentage alert condition
resource "newrelic_alert_condition" "error_percentage" {
  policy_id       = newrelic_alert_policy.golden_signal_policy.id
  name            = "High Error Percentage"
  type            = "apm_app_metric"
  entities        = [data.newrelic_entity.bible_beasts.application_id]
  metric          = "error_percentage"
  runbook_url     = "staging-bb-load-balancer-847918050.us-east-1.elb.amazonaws.com:3000"
  condition_scope = "application"

  # Define a critical alert threshold that will trigger after 5 minutes above a 5% error rate.
  term {
    duration      = 5
    operator      = "above"
    threshold     = "5"
    time_function = "all"
  }
}

# High CPU usage alert condition
resource "newrelic_infra_alert_condition" "high_cpu" {
  policy_id   = newrelic_alert_policy.golden_signal_policy.id
  name        = "High CPU usage"
  type        = "infra_metric"
  event       = "SystemSample"
  select      = "cpuPercent"
  comparison  = "above"
  runbook_url = "staging-bb-load-balancer-847918050.us-east-1.elb.amazonaws.com:3000"
  where       = "(`applicationId` = '${data.newrelic_entity.bible_beasts.application_id}')"

  # Define a critical alert threshold that will trigger after 5 minutes above 90% CPU utilization.
  critical {
    duration      = 5
    value         = 90
    time_function = "all"
  }
}

resource "newrelic_notification_destination" "team_email_destination" {
  name = "email-team"
  type = "EMAIL"

  property {
    key   = "email"
    value = "connor.high@gmail.com"
  }
}

resource "newrelic_notification_channel" "team_email_channel" {
  name           = "email-team-template"
  type           = "EMAIL"
  destination_id = newrelic_notification_destination.team_email_destination.id
  product        = "IINT"

  property {
    key   = "subject"
    value = "Alert! Issue with Bible-Beasts. They nead your help Spruce!"
  }
}

resource "newrelic_workflow" "sample_workflow" {
  name                  = "Bible Beasts Workflow"
  muting_rules_handling = "NOTIFY_ALL_ISSUES"

  issues_filter {
    name = "Issue Filter"
    type = "FILTER"
    predicate {
      attribute = "labels.policyIds"
      operator  = "EXACTLY_MATCHES"
      values    = [newrelic_alert_policy.golden_signal_policy.id]
    }
  }

  destination {
    channel_id = newrelic_notification_channel.team_email_channel.id
  }
}
