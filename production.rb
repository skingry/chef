node_name                  "monolith.robotozon.com"

file_cache_path            "/chef/cache"
file_backup_path           "/chef/backup"

log_level                  :info
verbose_logging            false

environment                "default"

cookbook_path              [ "/chef/cookbooks", "/chef/site-cookbooks" ]
environment_path           "/chef/environments"
role_path                  "/chef/roles"
data_bag_path              "/chef/data_bags"

