resource "aws_ecr_repository" "go-aws-terra-authors-image-repo" {
  name = "go-aws-terra-authors-image-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "go-aws-terra-telegram-image-repo" {
  name = "go-aws-terra-telegram-image-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
