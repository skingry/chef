#
# Cookbook Name:: headphones
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

include_recipe "apt"

apt_repository "ffmpeg" do
  uri "http://ppa.launchpad.net/jon-severinsson/ffmpeg/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "CFCA9579"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

package 'ffmpeg'

user "deploy" do
  supports :manage_home => true
  comment "Application User"
  uid 1000
  gid "nogroup"
  home "/home/deploy"
  shell "/bin/bash"
end

service "headphones" do
  supports :restart => true, :start => true
  action :nothing
end

directory "/var/run/headphones" do
  user "deploy"
  group "nogroup"
  action :create
end

cookbook_file "/etc/default/headphones" do
  source "headphones.options"
end

git "/home/deploy/headphones" do
  user "deploy"
  group "nogroup"
  repository "https://github.com/rembo10/headphones.git"
  revision "master"
  action :sync
  notifies :restart, "service[headphones]", :delayed
end

link "/etc/init.d/headphones" do
  to "/home/deploy/headphones/init-scripts/init.ubuntu"
end

service "headphones" do
  action :start
end

