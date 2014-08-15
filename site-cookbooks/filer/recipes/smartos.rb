#
# Cookbook Name:: filer
# Recipe:: smartos.rb
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

package 'nfs-utils'

directory "/shared" do
  action :create
end

execute "Add data partition to vfstab" do
  command "echo \"monolith.local.pvt:/zones/filer - /shared nfs - yes rsize=8192,wsize=8192,timeo=14,intr\" >> /etc/vfstab"
  not_if "cat /etc/vfstab | grep shared"
end

execute "Mount data partition" do
  command "mount -F nfs -o rsize=8192,wsize=8192,timeo=14,intr monolith.local.pvt:/zones/filer /shared"
  not_if "mount | grep shared"
end

