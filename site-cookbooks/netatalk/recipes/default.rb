#
# Cookbook Name:: netatalk
# Recipe:: default
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

include_recipe 'media-server::directories'
include_recipe 'netatalk::prerequisites'

netatalk_version = '3.1.8'
config_dir = '/data/configs/netatalk'

directory "#{config_dir}"

remote_file '/tmp/netatalk.tar.gz' do
  source "http://downloads.sourceforge.net/project/netatalk/netatalk/#{netatalk_version}/netatalk-#{netatalk_version}.tar.gz"
end

bash 'unpack netatalk' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  tar -zxf netatalk.tar.gz
  EOH
end

bash 'build netatalk' do
  user 'root'
  cwd "/tmp/netatalk-#{netatalk_version}"
  code <<-EOH
  ./configure \
    --prefix='/usr' \
    --sysconfdir="#{config_dir}" \
    --with-init-style=debian-systemd \
    --without-libevent \
    --without-tdb \
    --with-cracklib \
    --enable-krbV-uam \
    --with-pam-confdir=/etc/pam.d \
    --with-dbus-sysconf-dir=/etc/dbus-1/system.d \
    --with-tracker-pkgconfig-version=1.0
  make
  make install
  EOH
end

template "#{config_dir}/afp.conf" do
  variables(:hostname => node[:netatalk][:hostname])
end

cookbook_file '/sbin/netatalk' do
  mode 0755
end

directory '/data'

directory '/data/Backups' do
  owner 'nobody'
  group 'nogroup'
end

directory '/data/Downloads' do
  owner 'nobody'
  group 'nogroup'
end

directory '/data/Documents' do
  owner 'nobody'
  group 'nogroup'
end

directory '/data/Media' do
  owner 'nobody'
  group 'nogroup'
end
