#
# Cookbook Name:: media-server
# Recipe:: certbot
#
# Copyright 2016, Seth Kingry
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

docker_image 'certbot/dns-route53' do
  action :pull
end

cron 'Certbot Certificate Renewal' do
  minute '0'
  hour '3'
  weekday '1'
  command "docker run --rm -v '/data/configs/nginx/ssl:/config' -v '/data/configs/aws:/root/.aws' certbot/dns-route53 -n --dns-route53 --config-dir /config renew 2>&1 >> /var/log/certbot.log"
end
