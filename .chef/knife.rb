current_dir               = File.dirname(__FILE__)
eval File.read("#{current_dir}/secrets/config.rb")

log_level                 :info
log_location              STDOUT
node_name                 "#{chef_user}"
chef_server_url           "#{chef_url}"

cache_type                "BasicFile"
cache_options({ :path => "#{current_dir}/checksums", :skip_expires => true })

validation_client_name    "chef-validator"
validation_key            "#{current_dir}/secrets/chef-validator.pem"
client_key                "#{current_dir}/secrets/#{node_name}.pem"

cookbook_path             [ "#{current_dir}/../cookbooks" , "#{current_dir}/../site-cookbooks" ]
data_bag_path             "#{current_dir}/../data_bags"

