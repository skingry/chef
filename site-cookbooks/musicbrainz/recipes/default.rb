#
# Cookbook Name:: musicbrainz
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

include_recipe "musicbrainz::prerequisites"

include_recipe "perl"

user "deploy" do
  supports :manage_home => true
  comment "Application User"
  uid 1000
  gid "nogroup"
  home "/home/deploy"
  shell "/bin/bash"
end

git "/home/deploy/musicbrainz" do
  user "deploy"
  group "nogroup"
  repository "https://github.com/metabrainz/musicbrainz-server.git"
  revision "master"
  action :sync
end

cpan_module "Module::CPANfile"
cpan_module "MooseX::Singleton"

