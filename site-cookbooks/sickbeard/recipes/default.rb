#
# Cookbook Name:: sickbeard
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

user "sickbeard" do
  supports :manage_home => true
  comment "Sickbeard User"
  uid 1000
  gid "nogroup"
  home "/home/sickbeard"
  shell "/bin/bash"
end

service "sickbeard" do
  supports :restart => true, :start => true
  action :nothing
end

directory "/var/run/sickbeard" do
  user "sickbeard"
  group "nogroup"
  action :create
end

link "/etc/init.d/sickbeard" do
  to "/home/sickbeard/app/init.ubuntu"
end

cookbook_file "/etc/default/sickbeard" do
  source "sickbeard.options"
end

git "/home/sickbeard/app" do
  user "sickbeard"
  group "nogroup"
  repository "https://github.com/skingry/Sick-Beard.git"
  revision "master"
  action :sync
end

service "sickbeard" do
  action :start
end

