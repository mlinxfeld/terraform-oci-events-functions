variable "tenancy_ocid" {}
#variable "user_ocid" {}
#variable "fingerprint" {}
#variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "private_key_oci" {}
variable "public_key_oci" {}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "VCNname" {
  default = "FoggyKitchenVCN"
}

variable "Shapes" {
 default = ["VM.Standard2.1","VM.Standard.E2.1.Micro","VM.Standard2.1","VM.Standard.E2.1","VM.Standard.E2.2"]
}

variable "OsImage" {
  default = "Oracle-Linux-7.7-2020.02.21-0"
}

variable "bastion_ports" {
  default = ["22"]
}

variable "ocir_namespace" {
  default = ""
}

variable "ocir_repo_name" {
  default = ""
}

variable "ocir_docker_repository" {
  default = ""
}

variable "ocir_user_name" {
  default = ""
}

variable "ocir_user_password" {
  default = ""
}