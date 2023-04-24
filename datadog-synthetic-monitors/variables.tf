variable "datadog_api_key" {
    type = string
    sensitive = true
}

variable "datadog_app_key" {
    type = string
    sensitive = true
}

variable "domains" {
    type = list(string)
    default= ""
}

variable "environment" {
    type = string
    default = "qa"
}

variable "team" {
    type = string
    default = "esa"
}

variable "message" {
    type = string
}

