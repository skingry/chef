node_name                  "monolith.robotozon.com"

file_cache_path            "/root/chef/cache"
file_backup_path           "/root/chef/backup"

log_level                  :info
verbose_logging            false

environment                "production"

cookbook_path              [ "/root/chef/cookbooks", "/root/chef/site-cookbooks" ]
environment_path           "/root/chef/environments"
role_path                  "/root/chef/roles"
data_bag_path              "/root/chef/data_bags"
