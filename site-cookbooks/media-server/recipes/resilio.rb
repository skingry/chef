#
# Cookbook Name:: media-server
# Recipe:: resilio
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

docker_image 'resilio' do
  source '/data/configs/dockerfiles/resilio'
  action :build_if_missing
end

docker_container 'resilio' do
  repo 'resilio'
  memory '128M'
  port '55541:55541'
  volumes [
            '/data/configs/resilio:/config',
            '/data/shares:/shares',
            '/dev/rtc:/dev/rtc:ro',
            '/etc/localtime:/etc/localtime:ro'
          ]
  restart_policy 'always'
end
