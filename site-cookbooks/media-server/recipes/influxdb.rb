#
# Cookbook Name:: media-server
# Recipe:: influxdb
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

docker_image 'influxdb' do
  tag '1.8'
  action :pull
end

docker_container 'influxdb' do
  repo 'influxdb'
  tag '1.8'
  memory '512M'
  memory_swap '-1'
  port '127.0.0.1:8086:8086'
  volumes [ '/data/configs/influxdb:/etc/influxdb' ]
  restart_policy 'always'
end
