#
# Cookbook Name:: media-server
# Recipe:: grafana
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

docker_container 'grafana' do
  repo 'grafana/grafana'
  memory '128M'
  memory_swap '-1'
  user 'grafana'
  working_dir '/usr/share/grafana'
  links [ 'influxdb:influxdb.local' ]
  volumes [
            '/opt/config/grafana:/etc/grafana',
            '/opt/config/grafana/data:/var/lib/grafana',
            '/opt/config/grafana/data/plugins:/var/lib/grafana/plugins',
            '/opt/config/grafana/logs:/var/log/grafana'
          ]
  restart_policy 'always'
end
