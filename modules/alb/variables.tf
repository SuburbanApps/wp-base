variable "vpc_id" {
    description = "VPC ID where the ALB resources will be created."
    type = "string"
}

variable "public_subnets" {
    description = "VPC Public Subnets where the ALB resources will be created."
    type = list(string)
}
locals {
  environment_prefix          = "${lookup(local.env.environment_prefix, terraform.workspace)}"
  environment_name            = "${lookup(local.env.environment_name, terraform.workspace)}"
      env = {
      environment_prefix = {
        dev     = "dv10"
        staging = "st10"
        live    = "lv10"
          }
    
      environment_name = {
        dev     = "Development"
        staging = "Staging"
        live    = "Live"
        }

  }
  
  
  not_in_production = "${local.not_in_production_mapping[terraform.workspace]}" 
  not_in_production_mapping = {
    dev         = true
    staging     = true
    live        = false
  }
  
 }




