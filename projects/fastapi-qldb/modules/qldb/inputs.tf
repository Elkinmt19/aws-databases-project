variable "project_name" {
  description = "Nombre del proyecto."
  type        = string
  nullable    = false
}

variable "ledger_name" {
  description = "Nombre del QLDB ledger."
  type        = string
  nullable    = false
}

variable "env" {
  description = "Ambiente de despliegue. Sus únicos valores posibles serán: dev, qa, pdn."
  type        = string
  validation {
    condition     = contains(["dev", "qa", "pdn"], var.env)
    error_message = "Validar ambiente, solo esta permitido: dev, qa, pdn."
  }
  nullable = false
}

variable "qldb_permissions_mode" {
  description = "Tipos de permiso para los recursos del QLDB ledger"
  type        = string
  validation {
    condition     = contains(["STANDARD", "ALLOW_ALL"], var.qldb_permissions_mode)
    error_message = "Validar Tipo de permiso, solo esta permitido: STANDARD, ALLOW_ALL."
  }
  nullable = false
}

variable "qldb_deletion_protection" {
  description = "Previene la eliminación del ledger por parte de un usuario. Debe ser <false> para que Terraform pueda eliminar el recurso"
  type        = bool
  nullable    = false
}

variable "qldb_tags" {
  description = "Tags para el QLDB ledger"
  type        = map(string)
  nullable    = true
}
