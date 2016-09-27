#
# Cookbook Name:: nginx
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
config_dir = '/data/configs/nginx'

directory "#{config_dir}"
directory "#{config_dir}/logs"
directory "#{config_dir}/sites"
directory "#{config_dir}/ssl"
directory "#{config_dir}/webroot"

cookbook_file "#{config_dir}/sites/00-default.conf"
cookbook_file "#{config_dir}/webroot/50x.html"
cookbook_file "#{config_dir}/webroot/explosion-animation.gif"
cookbook_file "#{config_dir}/webroot/index.html"
cookbook_file "#{config_dir}/webroot/robot.gif"

template "#{config_dir}/nginx.conf" do
  variables :config_dir => "#{config_dir}"
end

