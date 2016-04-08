node_name                  "monolith.robotozon.com"

file_cache_path            "/var/chef/cache"
file_backup_path           "/var/chef/backup"

log_level                  :info
verbose_logging            false

encrypted_data_bag_secret  "/home/skingry/chef/encrypted_data_bag_secret"

cookbook_path              [ "/home/skingry/chef/cookbooks", "/home/skingry/chef/site-cookbooks" ]
environment_path           "/home/skingry/chef/environments"
role_path                  "/home/skingry/chef/roles"
data_bag_path              "/home/skingry/chef/data_bags"

environment                "production"

json_attribs               "/home/skingry/chef/config.json"
