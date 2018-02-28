node_name                  "monolith.robotozon.com"

file_cache_path            "/data/configs/chef/cache"
file_backup_path           "/data/configs/chef/backup"

log_level                  :info
verbose_logging            false

environment                "production"

cookbook_path              [ "/data/configs/chef/cookbooks", "/data/configs/chef/site-cookbooks" ]
environment_path           "/data/configs/chef/environments"
role_path                  "/data/configs/chef/roles"
data_bag_path              "/data/configs/chef/data_bags"
