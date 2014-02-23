#
# Cookbook Name:: nginx
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

package 'nginx' do
  action :install
end

file "/etc/nginx/sites-enabled/default" do
  action :delete
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
end

service "nginx" do
  supports :restart => true, :start => true
  action :start
end
