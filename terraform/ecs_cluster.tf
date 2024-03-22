# module "ecs" {
#   source = "terraform-aws-modules/ecs/aws"

#   cluster_name = "ecs-integrated"

#   cluster_configuration = {
#     execute_command_configuration = {
#       logging = "OVERRIDE"
#       log_configuration = {
#         cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
#       }
#     }
#   }

#   default_capacity_provider_use_fargate = false
#   autoscaling_capacity_providers = {

#   }

#   services = {
#     order-management-service = {
#       cpu    = 256
#       memory = 512

#       # Container definition(s)
#       container_definitions = {

#         # fluent-bit = {
#         #   cpu       = 512
#         #   memory    = 1024
#         #   essential = true
#         #   image     = "906394416424.dkr.ecr.us-west-2.amazonaws.com/aws-for-fluent-bit:stable"
#         #   firelens_configuration = {
#         #     type = "fluentbit"
#         #   }
#         #   memory_reservation = 50
#         # }

#         order-management-service = {
#           cpu       = 256
#           memory    = 512
#           essential = true
#           image     = "public.ecr.aws/q4w0a9y1/order-management-service:7a5e1864c300e7d0183803d683ff80c886d3ba57"
#           port_mappings = [
#             {
#                 "name": "order-management-service-8080-tcp",
#                 "containerPort": 8080,
#                 "hostPort": 8080,
#                 "protocol": "tcp",
#                 "appProtocol": "http"
#             }
#           ]

#           # Example image used requires access to write to root filesystem
#         #   readonly_root_filesystem = false

#         #   dependencies = [{
#         #     containerName = "fluent-bit"
#         #     condition     = "START"
#         #   }]

#           enable_cloudwatch_logging = true
#         #   log_configuration = {
#         #     logDriver = "awsfirelens"
#         #     options = {
#         #       Name                    = "firehose"
#         #       region                  = "eu-west-1"
#         #       delivery_stream         = "my-stream"
#         #       log-driver-buffer-limit = "2097152"
#         #     }
#         #   }
#         "logConfiguration": {
#             "logDriver": "awslogs",
#             "options": {
#                 "awslogs-create-group": "true",
#                 "awslogs-group": "/ecs/order-management-service",
#                 "awslogs-region": "us-west-1",
#                 "awslogs-stream-prefix": "ecs"
#             },
#             "secretOptions": []
#         }
#           memory_reservation = 100
#         }
#       }

#       service_connect_configuration = {
#         namespace = "example"
#         service = {
#           client_alias = {
#             port     = 80
#             dns_name = "ecs-sample"
#           }
#           port_name      = "ecs-sample"
#           discovery_name = "ecs-sample"
#         }
#       }

#       load_balancer = {
#         service = {
#           target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:1234567890:targetgroup/bluegreentarget1/209a844cd01825a4"
#           container_name   = "order-management-service"
#           container_port   = 80
#         }
#       }

#       subnet_ids = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
#       security_group_rules = {
#         alb_ingress_3000 = {
#           type                     = "ingress"
#           from_port                = 80
#           to_port                  = 80
#           protocol                 = "tcp"
#           description              = "Service port"
#           source_security_group_id = "sg-12345678"
#         }
#         egress_all = {
#           type        = "egress"
#           from_port   = 0
#           to_port     = 0
#           protocol    = "-1"
#           cidr_blocks = ["0.0.0.0/0"]
#         }
#       }
#     }
#   }

#   tags = {
#     Environment = "Development"
#     Project     = "Example"
#   }
# }