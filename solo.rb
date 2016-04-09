node_name                  "monolith.robotozon.com"

file_cache_path            "/var/chef/cache"
file_backup_path           "/var/chef/backup"

log_level                  :info
verbose_logging            false

cookbook_path              [ "/home/skingry/chef/cookbooks", "/home/skingry/chef/site-cookbooks" ]
environment_path           "/home/skingry/chef/environments"
role_path                  "/home/skingry/chef/roles"
data_bag_path              "/home/skingry/chef/data_bags"

json_attribs               "/home/skingry/chef/config.json"
