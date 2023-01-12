# Calculate hash of the Docker image source contents
data "external" "hash" {
  program = [coalesce(var.hash_script, "${path.module}/hash.sh"), var.source_path]
}

locals {
  docker_tag = var.tag == "hash" ? data.external.hash.result["hash"] : var.tag
}

# Build and push the Docker image whenever the hash changes
resource "null_resource" "push" {
  triggers = {
    hash = data.external.hash.result["hash"]
  }

  provisioner "local-exec" {
    command     = "${coalesce(var.push_script, "${path.module}/push.sh")} ${var.source_path} ${aws_ecr_repository.repo.repository_url} ${local.docker_tag}"
    interpreter = ["bash", "-c"]
  }
}
