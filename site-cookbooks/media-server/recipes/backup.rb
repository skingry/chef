#
# Cookbook Name:: media-server
# Recipe:: plex-cleaner
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

cookbook_file "/opt/bin/configs-backup.sh" do
  mode 0700
end

cron "Configs Backup" do
  minute "30"
  hour "3"
  day "1"
  path "/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin"
  user "root"
  mailto "sjkingry@gmail.com"
  command "/opt/bin/configs-backup.sh >> /dev/null"
end

