terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
      version = ">= 3.23.0"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

resource "datadog_synthetics_tests" "module" {
  count = length(var.domains)

  type    = "api"
  subtype = "http"
  request_definition {
    method = "GET"
    url    = "https://${var.domains[count.index]}"
  }
  request_headers = {
    Content-Type   = "application/json"
  }
  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }
  locations = ["aws:us-west-1","aws:us-east-1"]
  options_list {
    tick_every = 900

    retry {
      count    = 2
      interval = 30000
    }

    monitor_options {
      renotify_interval = 120
    }
  }
  name    = "${var.environment} - ${var.domains[count.index]}"
  message = var.message
  tags    = ["env:${var.environment}", "managed:terraformed", "team:${var.team}"]

  status = "live"
}