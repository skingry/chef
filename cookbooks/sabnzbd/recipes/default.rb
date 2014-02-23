#
# Cookbook Name:: sabnzbd
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

include_recipe "python-cheetah"
include_recipe "python-yenc"
include_recipe "unrar"
include_recipe "unzip"
include_recipe "par2"
include_recipe "nginx"

user "sabnzbd" do
  supports :manage_home => true
  comment "SABnzbd User"
  uid 1000
  gid "nogroup"
  home "/home/sabnzbd"
  shell "/bin/bash"
  password "$1$ZjRV27GR$M1si7V7dy/TZaaz3/4teH1"
end

service "sabnzbd" do
  supports :restart => true, :start => true
end

git "/home/sabnzbd/app" do
  user "sabnzbd"
  group "nogroup"
  repository "https://github.com/skingry/sabnzbd.git"
  reference "master"
  action :sync
  notifies :restart, resources(:service => "sabnzbd"), :delayed
end

link "/etc/init.d/sabnzbd" do
  to "/data/sabnzbd/init-script"
end

service "sabnzbd" do
  action :start
end

template "/etc/nginx/sites-enabled/sabnzbd" do
  source "sabnzbd.nginx.erb"
  notifies :restart, resources(:service => "nginx")
end

