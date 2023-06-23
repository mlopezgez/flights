module "ecr_repository" {
    source = "../../resources/ecr"
    name   = var.name
}