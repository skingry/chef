current_dir             = File.dirname(__FILE__)

log_level                 :info
log_location              STDOUT
node_name                 "skingry"
chef_server_url           "https://chef.local.pvt"

cache_type                "BasicFile"
cache_options({ :path => "#{current_dir}/cache/checksums", :skip_expires => true })

validation_client_name    "chef-validator"
validation_key            "#{current_dir}/secrets/chef-validator.pem"
client_key                "#{current_dir}/secrets/#{node_name}.pem"

cookbook_path             "#{current_dir}/../cookbooks"

eval File.read("#{current_dir}/secrets/fifo-config.rb")
eval File.read("#{current_dir}/secrets/joyent-config.rb")
