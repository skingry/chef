@chefdir    = File.expand_path("#{File.dirname(__FILE__)}")

log_level                 :info
log_location              STDOUT
node_name                 "skingry"
chef_server_url           "https://chef.local.pvt"

validation_client_name    "chef-validator"
validation_key            "#{@chefdir}/secrets/chef-validator.pem"
client_key                "#{@chefdir}/secrets/#{node_name}.pem"
