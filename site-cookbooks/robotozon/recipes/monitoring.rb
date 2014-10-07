#
# Cookbook Name:: robotozon
# Recipe:: monitoring
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

for plugin in [ "df_inode", "entropy", "forks", "fw_packets", "http_loadtime", "if_err_eth0", "interrupts", "irqstats", "nfsd", "nfsd4", "nfs4_client", "nfs_client", "ntp_kernel_err", "ntp_kernel_pll_freq", "ntp_kernel_pll_off", "open_files", "open_inodes", "proc_pri", "threads", "vmstat" ] do
  munin_plugin "#{plugin}" do
    enable false
  end
end

cookbook_file '/etc/init.d/munin-node' do
  mode "0755"
end

