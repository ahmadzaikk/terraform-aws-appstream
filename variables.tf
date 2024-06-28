variable "enable_vpce" {
  description = "Enable VPC endpoint for streaming"
  type        = bool
  default     = false
}

variable "name" {
  default     = ""
  description = "Appstream stack/fleet name"
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

variable "appstream_user_settings" {
  description = "User settings for AWS AppStream 2.0"
  type        = list(object({
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
    }
    // Add more settings as needed
  ]
}
