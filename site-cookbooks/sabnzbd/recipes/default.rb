#
# Cookbook Name:: sabnzbd
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
package 'python-yenc'
package 'unrar'
package 'unzip'
package 'par2'

user "deploy" do
  supports :manage_home => true
  comment "Application User"
  uid 1000
  gid "nogroup"
  home "/home/deploy"
  shell "/bin/bash"
end

service "sabnzbd" do
  supports :restart => true, :start => true
end

link "/etc/init.d/sabnzbd" do
  to "/shared/sabnzbd/init-script"
end

git "/home/deploy/sabnzbd" do
  user "deploy"
  group "nogroup"
  repository "https://github.com/sabnzbd/sabnzbd.git"
  revision "master"
  action :sync
  notifies :restart, "service[sabnzbd]"
end

service "sabnzbd" do
  action :start
end

