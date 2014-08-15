#
# Cookbook Name:: python3
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

include_recipe "python3::prerequisites"

python_version = "3.3.2"

remote_file "/tmp/python3.tar.gz" do
  source "http://www.python.org/ftp/python/#{python_version}/Python-#{python_version}.tgz"
  not_if "ls /tmp/python3.tar.gz"
end

remote_file "/tmp/get-pip.py" do
  source "https://raw.github.com/pypa/pip/master/contrib/get-pip.py"
  not_if "ls /tmp/get-pip.py"
end

bash "unpack python3" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  tar -zxf python3.tar.gz
  EOH
  not_if "ls /tmp/Python-#{python_version}"
end

bash "build python3" do
  user "root"
  cwd "/tmp/Python-#{python_version}"
  code <<-EOH
  ./configure --prefix=/usr/local
  make
  make install
  EOH
  not_if "ls /usr/local/bin/python3"
end

bash "install pip" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  python3 get-pip.py
  EOH
  not_if "which pip"
end

