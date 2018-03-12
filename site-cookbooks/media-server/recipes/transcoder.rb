#
# Cookbook Name:: media-server
# Recipe:: transcoder
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

docker_image 'transcoder' do
  source '/root/Dockerfiles/transcoder'
  action :build_if_missing
end

docker_container 'transcoder' do
  repo 'transcoder'
  memory '1024M'
  network_mode 'host'
  runtime 'nvidia'
  volumes [ 
            '/usr/lib/nvidia-384:/usr/lib/nvidia-384',
            '/data/configs/transcoder/config:/config',
            '/data/configs/transcoder/logs:/logs',
            '/data/shares/Media:/media',
            '/dev/rtc:/dev/rtc:ro', 
            '/etc/localtime:/etc/localtime:ro' 
          ]
  privileged true
  action :create
end

cron "Media Transcoder" do
  minute "*/10"
  mailto "#{node[:cron_mailto]}"
  command "docker start transcoder"
end
