node_name                  "monolith.robotozon.com"

root                       "/opt/config/chef"

file_cache_path            "/opt/config/chef/cache"
file_backup_path           "/opt/config/chef/backup"

log_level                  :info
verbose_logging            false

environment                "production"

cookbook_path              [ "/opt/config/chef/cookbooks", "/opt/config/chef/site-cookbooks" ]
environment_path           "/opt/config/chef/environments"
role_path                  "/opt/config/chef/roles"
data_bag_path              "/opt/config/chef/data_bags"
