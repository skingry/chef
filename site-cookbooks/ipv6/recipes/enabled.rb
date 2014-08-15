#
# Cookbook Name:: ipv6
# Recipe:: enabled
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

include_recipe "sysctl"

sysctl "net.ipv6.conf.all.autoconf" do
  value 1
end

sysctl "net.ipv6.conf.all.accept_ra" do
  value 1
end

sysctl "net.ipv6.conf.eth0.accept_dad" do
  value 0
end

