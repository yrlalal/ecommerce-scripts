module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "ecommerce-ecs-cluster"

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/ecommerce-ecs-cluster"
      }
    }
  }

  default_capacity_provider_use_fargate = false
  autoscaling_capacity_providers = {

  }

  services = {
    order-management-service = {
      cpu    = 256
      memory = 512

      # Container definition(s)
      container_definitions = {
        order-management-service = {
          cpu       = 256
          memory    = 512
          essential = true
          image     = "public.ecr.aws/q4w0a9y1/order-management-service:7a5e1864c300e7d0183803d683ff80c886d3ba57"
          port_mappings = [
            {
                "name": "order-management-service-8080-tcp",
                "containerPort": 8080,
                "hostPort": 8080,
                "protocol": "tcp",
                "appProtocol": "http"
            }
          ]

            enable_cloudwatch_logging = true

            logConfiguration = {
                logDriver = "awslogs",
                options = {
                    "awslogs-create-group": "true",
                    "awslogs-group": "/ecs/order-management-service",
                    "awslogs-region": "us-west-1",
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            }
            memory_reservation = 100
        }
      }

    #   service_connect_configuration = {
    #     namespace = "example"
    #     service = {
    #       client_alias = {
    #         port     = 80
    #         dns_name = "ecs-sample"
    #       }
    #       port_name      = "ecs-sample"
    #       discovery_name = "ecs-sample"
    #     }
    #   }

    #   load_balancer = {
    #     service = {
    #       target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:1234567890:targetgroup/bluegreentarget1/209a844cd01825a4"
    #       container_name   = "order-management-service-alb"
    #       container_port   = 8080
    #     }
    #   }

      subnet_ids = module.vpc.public_subnets
    #   security_group_rules = {
    #     alb_ingress_3000 = {
    #       type                     = "ingress"
    #       from_port                = 80
    #       to_port                  = 80
    #       protocol                 = "tcp"
    #       description              = "Service port"
    #       source_security_group_id = "sg-12345678"
    #     }
    #     egress_all = {
    #       type        = "egress"
    #       from_port   = 0
    #       to_port     = 0
    #       protocol    = "-1"
    #       cidr_blocks = ["0.0.0.0/0"]
    #     }
    #   }
    }
  }

  tags = {
    Environment = "Development"
    Project     = "ecommerce"
  }
}