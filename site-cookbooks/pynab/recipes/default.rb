#
# Cookbook Name:: pynab
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

package "unrar"
include_recipe "nginx"

user "pynab" do
  supports :manage_home => true
  supports :non_unique => true
  comment "Pynab User"
  uid 33
  gid "www-data"
  home "/home/pynab"
  shell "/bin/bash"
end

directory "/home/pynab" do
  owner "pynab"
  group "www-data"
end

git "/home/pynab/app" do
  user "pynab"
  group "www-data"
  repository "https://github.com/Murodese/pynab.git"
  revision "master"
  action :sync
end

template "/etc/nginx/sites-enabled/pynab" do
  source "pynab.nginx.erb"
  notifies :restart, "service[nginx]"
end

