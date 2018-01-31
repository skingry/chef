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

name = 'influxdb'
repo = "#{name}"

include_recipe 'directories'

directory "/data/configs/#{name}"

docker_image "#{name}" do
  repo "#{repo}"
  action :pull
end

docker_container "#{name}" do
  repo "#{repo}"
  memory '512M'
  port '127.0.0.1:8086:8086'
  volumes [ '/data/configs/influxdb:/var/lib/influxdb', '/data/configs/influxdb/influxdb.conf:/etc/influxdb/influxdb.conf:ro' ]
  restart_policy 'always'
end

