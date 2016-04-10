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

git "/opt/Plex-Cleaner" do
  repository "https://github.com/ngovil21/Plex-Cleaner.git"
  revision "master"
  action :sync
end

cron "Plex Cleaner" do
  minute "0"
  hour "3"
  user "nobody"
  mailto "sjkingry@gmail.com"
  command "/usr/bin/python /opt/Plex-Cleaner/PlexCleaner.py --config /data/configs/Plex-Cleaner/Cleaner.conf >> /dev/null"
end

