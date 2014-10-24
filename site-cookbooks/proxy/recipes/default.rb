#
# Cookbook Name:: proxy
# Recipe:: default
#
# Copyright 2014, Seth Kingry
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "nginx"

secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")
sickbeard_ssl = Chef::EncryptedDataBagItem.load("ssl", "sickbeard_robotozon_com", secret)

cookbook_file "/etc/nginx/htpasswd"

template "/etc/nginx/sites-available/couchpotato"
template "/etc/nginx/sites-available/sickbeard"
template "/etc/nginx/sites-available/sabnzbd"
template "/etc/nginx/sites-available/transmission"

nginx_site 'couchpotato'
nginx_site 'sickbeard'
nginx_site 'sabnzbd'
nginx_site 'transmission'

directory "/etc/nginx/ssl"

file "/etc/nginx/ssl/sickbeard.robotozon.com.crt" do
  content sickbeard_ssl['cert']
end

file "/etc/nginx/ssl/sickbeard.robotozon.com.key" do
  content sickbeard_ssl['key']
  mode "0600"
end

