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
package 'smartmontools'
package 'snmp'
package 'snmp-mibs-downloader'
package 'jq'
package 'ipmitool'
package 'openipmi'
package 'lm-sensors'
package 'fancontrol'

cookbook_file '/etc/fancontrol'
cookbook_file '/etc/modules'
cookbook_file '/etc/defaults/apcupsd'
cookbook_file '/etc/apcupsd/apcupsd.conf'


cron "Monitoring" do
  command "/data/configs/monitoring/monolith.sh"
end

