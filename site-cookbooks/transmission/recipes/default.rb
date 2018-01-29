#
# Cookbook Name:: transmission
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

include_recipe 'apt'

directory '/config' do
  owner 'nobody'
  group 'nogroup'
end

directory '/download' do
  owner 'nobody'
  group 'nogroup'
end

apt_repository 'transmissionbt' do
  uri 'http://ppa.launchpad.net/transmissionbt/ppa/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'keyserver.ubuntu.com'
  key '365C5CA1'
  action :add
  notifies :run, 'execute[apt-get update]', :immediately
end

package 'transmission-daemon'

cookbook_file '/sbin/transmission' do
  mode 0755
end

