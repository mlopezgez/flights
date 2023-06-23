module "ecr-repository" {
    source = "../../resources/ecr"
    name   = var.name
}