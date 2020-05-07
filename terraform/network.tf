resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"

  tags {
    Name = "hibicode" #nome da minha vpc pai
  }
}

resource "aws_subnet" "private_subnet" {
  count = 3 #for do terraform para iterar qtd de vezes colocado

  vpc_id = "${aws_vpc.main.id}" # setando o id do pai para criar os filhos

  cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 10)}" #variavel que incrementa o cidr_block(ip da rede) incrementando +10 para cada subrede
  availability_zone = "${var.availability_zones[count.index]}" #variavel que usa o arquivo variables.tf

  tags {
    Name = "hibicode_private_subnet_${count.index}"
  }
}

resource "aws_subnet" "public_subnet" {
  count = 3

  vpc_id = "${aws_vpc.main.id}"

  cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 20)}"
  availability_zone = "${var.availability_zones[count.index]}"
  map_public_ip_on_launch = true #criar um ip publico qdo subir a maquina

  tags {
    Name = "hibicode_public_subnet_${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table" "route_igw" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}" #para qualquer endereço que não seja o endereço publico vai redirecionar para a rota defaul da vpc
  }
}

resource "aws_route_table_association" "route_table_association" { #fas a associação do router com as subredes publicas
  count = 3
  route_table_id = "${aws_route_table.route_igw.id}"
  subnet_id = "${element(aws_subnet.public_subnet.*.id, count.index)}"
}
