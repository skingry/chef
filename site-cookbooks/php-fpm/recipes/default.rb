#
# Cookbook Name:: php-fpm
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

include_recipe "php"
include_recipe "sysctl"

package 'php5-curl'
package 'php5-dev'
package 'php5-fpm'
package 'php-services-json'
package 'php5-sqlite'
package 'php5-xmlrpc'

package 'libyaml-0-2'
package 'libyaml-dev'

directory "/etc/php5/conf.d" do
  recursive true
end

php_pear "yaml" do
  action :install
end

if node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 13.10
  service "php5-fpm" do
    provider Chef::Provider::Service::Upstart
    action :enable
    supports :enable => true, :disable => true, :restart => true, :reload => true
  end
else
  service "php5-fpm" do
    action :enable
    supports :enable => true, :disable => true, :restart => true, :reload => true
  end
end

template "/etc/php5/fpm/php.ini" do
  notifies :restart, "service[php5-fpm]"
end

template "/etc/php5/fpm/php-fpm.conf" do
  notifies :restart, "service[php5-fpm]"
end

template "/etc/php5/fpm/pool.d/www.conf" do
  notifies :restart, "service[php5-fpm]"
end

if node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 13.10
  link "/etc/php5/fpm/conf.d/20-yaml.ini" do
    to "/etc/php5/conf.d/yaml.ini"
    notifies :restart, "service[php5-fpm]"
  end
end

sysctl "net.core.somaxconn" do
  value 1024
end

