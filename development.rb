node_name                  "monolith.media-server-testing.com"

file_cache_path            "/var/chef/cache"
file_backup_path           "/var/chef/backup"

log_level                  :info
verbose_logging            false

environment                "development"

cookbook_path              [ "/home/vagrant/chef/cookbooks", "/home/vagrant/chef/site-cookbooks" ]
environment_path           "/home/vagrant/chef/environments"
role_path                  "/home/vagrant/chef/roles"
data_bag_path              "/home/vagrant/chef/data_bags"

json_attribs               "/home/vagrant/chef/config.json"

