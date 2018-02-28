#
# Cookbook Name:: media-server
# Recipe:: sabnzbd
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

docker_image 'sabnzbd' do
  source '/root/Dockerfiles/sabnzbd'
  action :build_if_missing
end

docker_container 'sabnzbd' do
  repo 'sabnzbd'
  memory '1536M'
  network_mode 'container:openvpn'
  volumes [ 
            '/data/configs/sabnzbd:/config', 
            '/data/shares/Downloads:/download', 
            '/dev/rtc:/dev/rtc:ro', 
            '/etc/localtime:/etc/localtime:ro' 
          ]
  restart_policy 'always'
end
