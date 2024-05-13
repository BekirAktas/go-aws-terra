resource "aws_secretsmanager_secret" "db_password_1" {
  name = "db/postgres/password1"
}

resource "aws_secretsmanager_secret_version" "db_password_version" {
  secret_id = aws_secretsmanager_secret.db_password_1.id
  secret_string = var.db_password_1
}

resource "aws_secretsmanager_secret" "db_username_1" {
  name = "db/postgres/username1"
}

resource "aws_secretsmanager_secret_version" "db_username_version" {
  secret_id = aws_secretsmanager_secret.db_username_1.id
  secret_string = var.db_username_1
}
