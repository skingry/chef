#
# Cookbook Name:: speedtest
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
include_recipe "php"

directory "/usr/share/nginx/mini"

cookbook_file "mini.zip" do
  path "/tmp/mini.zip"
end

execute "Unzip Speedtest.net Mini server" do
  command "cd /usr/share/nginx/ && unzip /tmp/mini.zip"
  only_if "ls /tmp/mini.zip"
  not_if "ls /usr/share/nginx/mini/index-php.html"
end

link "/usr/share/nginx/mini/index.php" do
  to "/usr/share/nginx/mini/index-php.html"
end

template "/etc/nginx/sites-enabled/speedtest" do
  notifies :restart, "service[nginx]"
end
