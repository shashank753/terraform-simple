module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.24.2"
  cluster_name    = "shashank_demo"
  cluster_version = "1.30"
  subnet_ids = [
  aws_subnet.pvt1.id,
  aws_subnet.pvt2.id,
  aws_subnet.pvt3.id,
]

  enable_irsa = true

  tags = {
    cluster = "demo"
  }

  vpc_id = aws_vpc.main.id

  eks_managed_node_group_defaults = {
    ami_type               = "AL2023_x86_64_STANDARD"
    instance_types         = ["t3.medium"]
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  }

  eks_managed_node_groups = {

    node_group = {
      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
}