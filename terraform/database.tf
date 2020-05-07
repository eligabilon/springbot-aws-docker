module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "1.21.0"

  identifier = "hibicode-beerstore-rds"

  engine = "postgres"
  engine_version = "10.4"
  instance_class = "db.t2.micro"
  allocated_storage = "100"

  name = "beerstore"
  username = "beerstore"
  password = "beerstore"
  port = "5432"

  vpc_security_group_ids = ["${aws_security_group.database.id}"]

  maintenance_window = "Thu:03:30-Thu:05:30" #janela de manutenção somente nesse horário estipulado
  backup_window = "05:30-06:30" #backup tb somente nesse horário
  storage_type = "gp2" #tipo de armazenamento gp2 é parecido com ssd algo do tipo
  multi_az = "true" #quero novos bancos em espera no caso nas subnets
  family = "postgres10"

  subnet_ids = "${flatten(chunklist(aws_subnet.private_subnet.*.id, 1))}" #todas as subnets que serão criadas esses bancos

}