resource "aws_ecr_repository" "go-aws-terra-image-repo" {
  name = "go-aws-terra-image-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
