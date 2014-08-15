#
# Cookbook Name:: mysql
# Recipe:: server
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

include_recipe 'mysql::client'

package 'percona-server-server-5.6'
package 'percona-toolkit'

template '/etc/mysql/my.cnf' do
  source 'my.cnf.erb'
  mode '0644'
end

# Linking the 'default' location of the my.cnf to the location that the rest of the world expects it

cookbook_file '/tmp/mysql_restore.sh' do
  mode '0755'
end

template '/tmp/mysql_backup.sh' do
  mode '0755'
end

# This stuff resets the root password if needed

cookbook_file '/tmp/reset-root-password.sh' do
  mode 0700
end

bash 'set blank root password for mysql' do
  user 'root'
  code '/tmp/reset-root-password.sh'
  not_if { ::File.exists?('/root/.my.cnf') }
end

# This stuff is needed universally by the BI team for timezone conversions in their reports

execute "add timezone tables to mysql" do
  command "/usr/bin/mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql"
  only_if "mysql -e \"show databases;\" | grep mysql"
  not_if "mysql -e \"select * from mysql.time_zone;\" | grep leap_seconds"
end

