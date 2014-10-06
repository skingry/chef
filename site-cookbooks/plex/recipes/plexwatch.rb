#
# Cookbook Name:: plex
# Recipe:: plexwatch
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
include_recipe "plexwatch::prerequisites"

directory "/opt/plexWatch"

remote_file "/opt/plexWatch/plexWatch.pl" do
  source "https://raw.github.com/ljunkie/plexWatch/master/plexWatch.pl"
  mode 0755
  not_if "ls /opt/plexWatch/plexWatch.pl"
end

link "/opt/plexWatch/config.pl" do
  to "/shared/plexwatch/config.pl"
end

cron "PlexWatch" do
  command "/opt/plexWatch/plexWatch.pl"
end

directory "/usr/share/nginx/www/plexwatch" do
  owner "www-data"
  group "www-data"
end

git "/usr/share/nginx/www/plexwatch" do
  user "www-data"
  group "www-data"
  repository "https://github.com/ecleese/plexWatchWeb.git"
  revision "master"
  action :sync
end

template "/etc/nginx/sites-enabled/plexwatch" do
  notifies :restart, "service[nginx]"
end

