#
# Cookbook Name:: mysql
# Recipe:: backup
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

# Setup regularly scheduled backups (occuring at midnight PDT), and logging output to a temporary file

schedule = node[:mysql][:backup][:crontab_schedule]

cron 'Innobackup' do
  minute schedule[0]
  hour schedule[1]
  day schedule[2]
  month schedule[3]
  weekday schedule[4]
  command '/tmp/mysql_backup.sh 2>&1 > /tmp/db_backup.log'
end

