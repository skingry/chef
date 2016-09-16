#
# Cookbook Name:: docker-nginx
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

package 'nginx'

cookbook_file '/etc/nginx/nginx.conf'

directory '/config'
directory '/config/logs'
directory '/config/sites'
directory '/config/webroot'

cookbook_file '/config/sites/00-default.conf'
cookbook_file '/config/webroot/50x.html'
cookbook_file '/config/webroot/explosion-animation.gif'
cookbook_file '/config/webroot/index.html'
cookbook_file '/config/webroot/robot.gif'

cookbook_file '/sbin/my_init' do
  mode 0755
end

