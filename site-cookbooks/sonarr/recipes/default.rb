#
# Cookbook Name:: sonarr
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
include_recipe 'media-server::directories'

apt_repository 'nzbdrone' do
  uri 'http://apt.sonarr.tv/'
  distribution 'master'
  components ['main']
  keyserver 'keyserver.ubuntu.com'
  key 'FDA5DFFC'
  action :add
  notifies :run, 'execute[apt-get update]', :immediately
end

package 'nzbdrone'

directory '/data/configs/sonarr' do
  owner 'nobody'
  group 'nogroup'
end

cookbook_file '/sbin/sonarr' do
  mode 0755
end

