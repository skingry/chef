#
# Cookbook Name:: media-server
# Recipe:: monitoring
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

package 'apcupsd'
package 'bc'
package 'smartmontools'
package 'snmp'
package 'snmp-mibs-downloader'
package 'jq'
package 'lm-sensors'
package 'fancontrol'

service 'fancontrol' do
  action :start
end

cookbook_file '/etc/modules'
cookbook_file '/etc/modprobe.d/lm_sensors.conf'
cookbook_file '/etc/sensors.d/it8728.conf'
cookbook_file '/etc/default/apcupsd'
cookbook_file '/etc/apcupsd/apcupsd.conf'
cookbook_file '/etc/rc.local'

cookbook_file '/usr/sbin/fancontrol' do
  source 'fancontrol.sbin'
  notifies :restart, 'service[fancontrol]', :delayed
end

cookbook_file '/etc/fancontrol' do
  notifies :restart, 'service[fancontrol]', :delayed
end

cron "Monitoring" do
  mailto "#{node[:cron_mailto]}"
  command "/data/configs/monitoring/monolith.sh 2>&1 >> /dev/null"
end

