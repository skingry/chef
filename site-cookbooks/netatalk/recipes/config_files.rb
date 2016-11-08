#
# Cookbook Name:: netatalk
# Recipe:: config_files
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

include_recipe 'media-server::directories'

config_dir = '/data/configs/netatalk'

directory "#{config_dir}"

template "#{config_dir}/afp.conf" do
  variables(:hostname => node[:netatalk][:hostname])
  not_if do ::File.exists?("#{config_dir}/afp.conf") end
end

directory '/data'

directory '/data/Backups' do
  owner 'nobody'
  group 'nogroup'
end

directory '/data/Downloads' do
  owner 'nobody'
  group 'nogroup'
end

directory '/data/Documents' do
  owner 'nobody'
  group 'nogroup'
end

directory '/data/Media' do
  owner 'nobody'
  group 'nogroup'
end
