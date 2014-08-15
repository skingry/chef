#
# Cookbook Name:: php
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

package 'php5-fpm'
package 'php5-mysql'
package 'php5-sqlite'
package 'php5-curl'
package 'php-services-json'

service "php5-fpm" do
  supports :start => true, :stop => true, :restart => true
  action :start
end

template '/etc/php5/fpm/php.ini' do
  notifies :restart, "service[php5-fpm]"
end

template '/etc/php5/fpm/php-fpm.conf' do
  notifies :restart, "service[php5-fpm]"
end

template '/usr/share/nginx/www/info.php'

