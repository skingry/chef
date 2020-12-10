#
# Cookbook Name:: media-server
# Recipe:: plex
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

docker_image 'plexinc/pms-docker' do
  action :pull
  tag 'plexpass'
end

docker_container 'plex' do
  repo 'plexinc/pms-docker'
  tag 'plexpass'
  memory '4096M'
  memory_swap '-1'
  network_mode 'host'
  privileged true
  env [
        'TZ=America/New_York',
        'CHANGE_CONFIG_DIR_OWNERSHIP=false',
        'PLEX_UID=65534',
        'PLEX_GID=65534'
      ]
  volumes [
            '/data/configs/plex:/config',
            '/data/shares/Media:/media',
            '/tmp:/tmp'
          ]
  devices [
            {
              "PathOnHost"=>"/dev/dri/card0",
              "PathInContainer"=>"/dev/dri/card0",
              "CgroupPermissions"=>"mrw"
            },
            {
              "PathOnHost"=>"/dev/dri/renderD128",
              "PathInContainer"=>"/dev/dri/renderD128",
              "CgroupPermissions"=>"mrw"
            }
          ]
  restart_policy 'always'
end
