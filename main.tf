module "infr" {
  source = "./modules/infr"
  vpc_cidr = var.vpc_cidr
  vpc_id = module.infr.vpc_id
  igw_id = module.infr.igw_id
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs = var.azs
  nat_gateway_id    = module.infr.nat_gateway_id
  private_subnet_ids = module.infr.private_subnet_ids
  public_subnet_ids = module.infr.public_subnet_ids
}

module "instances" {
  source = "./modules/instances"
  public_subnets = module.infr.public_subnet_ids
  private_subnets = module.infr.private_subnet_ids
  public_sg = module.infr.public_sg_id
  private_sg = module.infr.private_sg_id
  alb_dns_name = module.load-balancers.alb_dns_name
  
}

module "load-balancers" {
  source = "./modules/load-balancers"
  vpc_id = module.infr.vpc_id
  public_subnets = module.infr.public_subnet_ids
  private_subnets = module.infr.private_subnet_ids
  public_instance_ids = module.instances.public_instance_ids
  private_instance_ids = module.instances.private_instance_ids
  alb_sg      = module.load-balancers.alb_sg_id 
  private = module.instances.private
  private1 = module.instances.private1
}

module "s3" {
  source             = "./modules/s3"
  
}
module "dynamodb" {
  source             = "./modules/dynamodb"
  
}