region                               = "us-east-2"
subnet_name_filters_for_cluster      = [""]
subnet_name_filters_for_nodes        = [""]
base_domain                          = "aws.twistedlife.space"
cluster_name                         = "rancher"
kubernetes_version                   = "1.21.7"
ingress_nginx_version                = "3.12.0"
ingress_nginx_values_filename        = "value"
cert_manager_version                 = "v1.17.2"
cert_manager_letsencrypt_email       = "syork@yorkserv.com"
cert_manager_letsencrypt_environment = "production"
cert_manager_values_filename         = "value"
rancher_version                      = "2.6.3"
rancher_admin_password               = "MyB00tstr@pP@ssword"
rancher_values_filename              = "value"
vpc_create                           = true
base_domain_create                   = true