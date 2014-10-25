#
# Cookbook Name:: handbrake
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

include_recipe "apt"

apt_repository "handbrake" do
  uri "http://ppa.launchpad.net/stebbins/handbrake-releases/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "816950D8"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

package 'handbrake-cli'

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

