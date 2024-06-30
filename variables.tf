variable "enable_vpce" {
  description = "Enable VPC endpoint for streaming"
  type        = bool
  default     = false
}

variable "appstream_fleets" {
  description = "Map of fleet configurations."
  type = map(object({
    instance_type = string
    image_name    = string
  }))
}

variable "name" {
  default     = ""
  description = "Appstream stack/fleet name"
}
variable "enable_default_internet_access" {
  default     = "false"
  description = "enable Internet access"
}
variable "region" {
  default     = "us-west-2"
  description = "aws region"
}

variable "instance_type" {
  default = "stream.standard.medium"

}

variable "fleet_type" {
  default = "ON_DEMAND"

}

variable "image_name" {
  default = "AppStream-WinServer2016-06-17-2024"

}

variable "max_user_duration_in_seconds" {
  default = 600
  type    = number

}

variable "disconnect_timeout_in_seconds" {
  default = 300
  type    = number
}

variable "min_capacity" {
  default = 1
  type    = number
}
variable "max_capacity" {
  default = 5
  type    = number
}

variable "stream_view" {
  default = "DESKTOP"

}

variable "subnet_ids" {
  default = []
  type    = list(string)

}

variable "security_group_ids" {
  default = []
  type = list(string)
  
}

variable "vpc_id" {
  default = ""
  type = string
}

variable "desired_instances" {
  default = 1
  type = number
  
}


variable "tags" {
  default     = {}
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "user_settings" {
  description = "List of user settings for the AppStream stack"
  type = list(object({
    action     = string
    permission = string
  }))
  default = [
    {
      action     = "CLIPBOARD_COPY_FROM_LOCAL_DEVICE"
      permission = "ENABLED"
    },
    {
      action     = "CLIPBOARD_COPY_TO_LOCAL_DEVICE"
      permission = "ENABLED"
    },
    {
      action     = "FILE_UPLOAD"
      permission = "ENABLED"
    },
    {
      action     = "FILE_DOWNLOAD"
      permission = "ENABLED"
    },
    {
      action     = "PRINTING_TO_LOCAL_DEVICE"
      permission = "ENABLED"
    },
   {
    action     = "DOMAIN_PASSWORD_SIGNIN"
    permission = "DISABLED"
    },
    {
    action     = "DOMAIN_SMART_CARD_SIGNIN"
    permission = "DISABLED"
    }
  ]
}
