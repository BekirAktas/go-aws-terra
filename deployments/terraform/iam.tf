resource "aws_iam_role" "node-group-role" {
  name = "node-roles"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks-worker-node-policy" {
  role       = aws_iam_role.node-group-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

}

resource "aws_iam_role_policy_attachment" "ec2-container-registry" {
  role       = aws_iam_role.node-group-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_user" "ecr-admin-circleci" {
  name = "ecr-admin-circleci"
}

resource "aws_iam_user_policy_attachment" "ecr-admin-circleci-policy" {
  user       = aws_iam_user.ecr-admin-circleci.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}
