#
# Cookbook Name:: php-fpm
# Attributes:: default
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

default[:php_fpm][:user]                             = "www-data"
default[:php_fpm][:group]                            = "www-data"
default[:php_fpm][:listen]                           = "127.0.0.1:9000"
default[:php_fpm][:mode]                             = "0660"
default[:php_fpm][:listen_allowed_clients]           = "127.0.0.1"
default[:php_fpm][:max_children]                     = "60"
default[:php_fpm][:start_servers]                    = "30"
default[:php_fpm][:min_spare_servers]                = "30"
default[:php_fpm][:max_spare_servers]                = "30"
default[:php_fpm][:max_requests]                     = "2000"
default[:php_fpm][:emergency_restart_threshold]      = "10"
default[:php_fpm][:emergency_restart_interval]       = "1m"
default[:php_fpm][:process_control_timeout]          = "10s"

# php.ini tunable attributes
default[:php_fpm][:ini][:allow_url_fopen]            = "On"
default[:php_fpm][:ini][:allow_url_include]          = "Off"
default[:php_fpm][:ini][:max_input_vars]             = "1000"
default[:php_fpm][:ini][:memory_limit]               = "128M"
default[:php_fpm][:ini][:post_max_size]              = "8M"
default[:php_fpm][:ini][:upload_max_filesize]        = "2M"
default[:php_fpm][:ini][:upload_tmp_dir]             = "/tmp"

