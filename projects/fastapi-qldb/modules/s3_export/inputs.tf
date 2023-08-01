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

variable "aws_account" {
  description = "Numero de la Cuenta de AWS"
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
