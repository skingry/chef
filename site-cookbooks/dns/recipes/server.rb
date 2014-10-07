#
# Cookbook Name:: dns
# Recipe:: server
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

include_recipe "dns::prerequisites"

package 'pdns-recursor'
package 'bind9utils'

secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")
dns_secrets = Chef::EncryptedDataBagItem.load("secrets", "dns", secret)

node.set['mysql']['server_root_password'] = dns_secrets['mysql_root_password']

include_recipe "mysql::server"

template "/root/.my.cnf" do
  source "my.cnf.erb"
  mode "0600"
  variables(:mysql_root_password => dns_secrets['mysql_root_password'])
end

git "/tmp/pdns" do
  repository "https://github.com/PowerDNS/pdns.git"
  revision "master"
  action :sync
  not_if "ls /tmp/pdns"
end

bash "build and install PowerDNS" do
  user "root"
  cwd "/tmp/pdns"
  code <<-EOH
  ./bootstrap
  ./configure --with-modules="gmysql" --without-lua --prefix=/usr --sysconfdir=/etc/powerdns
  make
  make install
  EOH
  not_if "which pdns_server"
end

cookbook_file '/etc/init.d/pdns' do
  mode "0755"
end

service 'pdns' do
  supports :restart => true, :start => true
  action :nothing
end

service 'pdns-recursor' do
  supports :restart => true, :start => true
  action :nothing
end

template '/tmp/pdns.sql' do
  variables(:gmysql_host => dns_secrets['gmysql_host'],
            :gmysql_dbname => dns_secrets['gmysql_dbname'],
            :gmysql_user => dns_secrets['gmysql_user'],
            :gmysql_password => dns_secrets['gmysql_password'],
            :tsig_name => dns_secrets['tsig_name'],
            :tsig_key => dns_secrets['tsig_key'])
end

execute "setup pdns database" do
  command "mysql < /tmp/pdns.sql"
  only_if "ls /tmp/pdns.sql"
  not_if 'echo "show databases;" | mysql | grep [p]dns'
end

template '/etc/powerdns/recursor.conf' do
  notifies :restart, "service[pdns-recursor]", :delayed
end

template '/etc/powerdns/pdns.conf'do
  variables(:gmysql_host => dns_secrets['gmysql_host'],
            :gmysql_dbname => dns_secrets['gmysql_dbname'],
            :gmysql_user => dns_secrets['gmysql_user'],
            :gmysql_password => dns_secrets['gmysql_password'])
  notifies :restart, "service[pdns]", :delayed
end

