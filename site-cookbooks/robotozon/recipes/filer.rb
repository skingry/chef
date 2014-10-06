#
# Cookbook Name:: robotozon
# Recipe:: filer
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

package 'nfs-common'

directory "/shared" do
  action :create
end

mount "/shared" do
  device "monolith.local.pvt:/zones/filer"
  fstype "nfs"
  action [:mount, :enable]
  options "rsize=8192,wsize=8192,timeo=14,intr"
end

