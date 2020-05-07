resource "aws_key_pair" "keypair" {
  public_key = "${file("key/beerstore_key.pub")}" #caminho da minha chave publica ssh
}

#provisiono uma instancia para cada vpc
resource "aws_instance" "instances" {
  count = 3

  ami = "ami-04681a1dbd79675a5" #nome do so disponibilizado pela AWS
  instance_type = "t2.micro" #nome da instancia tb disponiblizado pela AWS

  subnet_id = "${element(aws_subnet.public_subnet.*.id, count.index)}" #pego todas as instancias um elemento de cada vez para vincular a subnet

  key_name = "${aws_key_pair.keypair.key_name}" #nome da minha chave associação da chave a aws para acesso maquina -> cloud

  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"
    , "${aws_security_group.allow_outbound.id}", "${aws_security_group.cluster_communication.id}"
    , "${aws_security_group.allow_app.id}", "${aws_security_group.database.id}"]

  tags {
    Name = "hibicode_instances"
  }
}

data "template_file" "hosts" {
  template = "${file("./template/hosts.tpl")}"

  vars { #pegando ip automatico da AWS atravez do arquivo template/hosts.tpl
    PUBLIC_IP_0 = "${aws_instance.instances.*.public_ip[0]}"
    PUBLIC_IP_1 = "${aws_instance.instances.*.public_ip[1]}"
    PUBLIC_IP_2 = "${aws_instance.instances.*.public_ip[2]}"

    PRIVATE_IP_0 = "${aws_instance.instances.*.private_ip[0]}"
  }
}

resource "local_file" "hosts" { #aqui ele cria um arquivo hosts com os ip's fixos da AWS de forma atumatica
  content = "${data.template_file.hosts.rendered}"
  filename = "./hosts"
}

output "public_ips" {
  value = "${join(", ", aws_instance.instances.*.public_ip)}" #somente para mostrar ips publicos no console
}
