node_name                  "container.docker.local"

file_cache_path            "/chef/cache"
file_backup_path           "/chef/backup"

log_level                  :info
verbose_logging            false

environment                "docker"

cookbook_path              [ "/chef/cookbooks", "/chef/site-cookbooks" ]
environment_path           "/chef/environments"
role_path                  "/chef/roles"
data_bag_path              "/chef/data_bags"

