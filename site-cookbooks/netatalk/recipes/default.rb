#
# Cookbook Name:: netatalk
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

include_recipe "netatalk::prerequisites"

netatalk_version = "3.1.7"

user "netatalk" do
  supports :manage_home => true
  comment "Netatalk User"
  uid 1000
  gid "nogroup"
  home "/home/netatalk"
  shell "/bin/bash"
end

remote_file "/tmp/netatalk.tar.gz" do
  source "http://downloads.sourceforge.net/project/netatalk/netatalk/#{netatalk_version}/netatalk-#{netatalk_version}.tar.gz"
  not_if "ls /tmp/netatalk.tar.gz"
end

bash "unpack netatalk" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  tar -zxf netatalk.tar.gz
  EOH
  not_if "ls /tmp/netatalk-#{netatalk_version}"
end

bash "build netatalk" do
  user "root"
  cwd "/tmp/netatalk-#{netatalk_version}"
  code <<-EOH
  ./configure --enable-debian --enable-zeroconf --with-cracklib --with-acls --enable-tcp-wrappers --with-init-style=debian
  make
  make install
  EOH
  not_if "ls /usr/local/sbin/afpd"
end

service "netatalk" do
  supports :enable => true, :restart => true, :start => true
  action :enable
end

template "/usr/local/etc/afp.conf" do
  notifies :restart, "service[netatalk]"
end

