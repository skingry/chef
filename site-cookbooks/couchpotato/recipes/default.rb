#
# Cookbook Name:: couchpotato
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

include_recipe "python"

package 'python-cheetah'

user "deploy" do
  supports :manage_home => true
  comment "Application User"
  uid 1000
  gid "nogroup"
  home "/home/deploy"
  shell "/bin/bash"
end

service "couchpotato" do
  supports :restart => true, :start => true
  action :nothing
end

directory "/var/run/couchpotato" do
  user "deploy"
  group "nogroup"
  action :create
end

cookbook_file "/etc/default/couchpotato" do
  source "couchpotato.options"
end

git "/home/deploy/couchpotato" do
  user "deploy"
  group "nogroup"
  repository "https://github.com/RuudBurger/CouchPotatoServer.git"
  revision "master"
  action :sync
  notifies :restart, "service[couchpotato]", :delayed
end

link "/etc/init.d/couchpotato" do
  to "/home/deploy/couchpotato/init/ubuntu"
end

service "couchpotato" do
  action :start
end

