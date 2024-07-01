variable "enable_vpce" {
  description = "Enable VPC endpoint for streaming"
  type        = bool
  default     = false
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
  description = "Instance Type"

}

variable "fleet_type" {
  default = "ON_DEMAND"
  description = "Fleet Type ON-DEMOND OR ALWAYS-ON"

}

variable "image_name" {
  default = "AppStream-WinServer2016-06-17-2024"
  description = "Image Name"

}

variable "max_user_duration_in_seconds" {
  default = 600
  type    = number
   description = "Max user Duration"

}

variable "disconnect_timeout_in_seconds" {
  default = 300
  type    = number
  description = "Disconnect TimeOut"
}


variable "idle_disconnect_timeout_in_seconds" {
  default = 600
  type    = number
  description = "Idle Timeout"
}


variable "desired_sessions" {
  default = null
  type    = number
  description = "Desired Session"
}
variable "max_sessions_per_instance" {
  default = null
  type    = number
  description = "Max Sessions per instance"

}

variable "stream_view" {
  default = "DESKTOP"
  description = "Stream View DESKTOP or APPS"

}

variable "subnet_ids" {
  default = []
  type    = list(string)
  description = "List of Subnets"

}

variable "security_group_ids" {
  default = []
  type = list(string)
  description = "Security Group ID"
  
}

variable "vpc_id" {
  default = ""
  type = string
  description = "VPC ID"
}

variable "desired_instances" {
  default = 1
  type = number
  description = "Desired Instance Number"
  
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
