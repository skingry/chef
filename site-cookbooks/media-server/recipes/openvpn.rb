#
# Cookbook Name:: media-server
# Recipe:: openvpn
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

name = 'openvpn'

include_recipe 'directories'

docker_container "#{name}" do
  repo "#{name}"
  memory '64M'
  cap_add 'NET_ADMIN'
  devices [{ "PathOnHost"=>"/dev/net/tun", "PathInContainer"=>"/dev/net/tun", "CgroupPermissions"=>"mrw"}]
  dns [ '8.8.8.8', '8.8.4.4' ]
  volumes [ '/data/configs/openvpn:/config' ]
  privileged true
  command '/usr/sbin/openvpn --config /config/newshosting.ovpn'
  restart_policy 'always'
end

