#
# Cookbook Name:: mysql
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

# General attributes
default[:mysql][:bind_address]                                 = '0.0.0.0'
default[:mysql][:server_id]                                    = `ifconfig -a | grep 192 | awk '{print $2}' | awk -F"." '{print $3$4}'`.strip.to_i
default[:mysql][:replica_specific]                             = 'no'

# Tunable attributes
default[:mysql][:tunable][:max_connections]                    = '1500'
default[:mysql][:tunable][:connect_timeout]                    = '10'
default[:mysql][:tunable][:net_read_timeout]                   = '10'
default[:mysql][:tunable][:net_write_timeout]                  = '10'
default[:mysql][:tunable][:net_buffer_length]                  = '16384'
default[:mysql][:tunable][:read_buffer_size]                   = '16M'
default[:mysql][:tunable][:thread_cache]                       = '256'
default[:mysql][:tunable][:innodb_buffer_pool_size]            = '512M'
default[:mysql][:tunable][:innodb_buffer_pool_instances]       = '1'
default[:mysql][:tunable][:innodb_read_io_threads]             = '8'
default[:mysql][:tunable][:innodb_write_io_threads]            = '8'
default[:mysql][:tunable][:innodb_io_capacity]                 = '1000'
default[:mysql][:tunable][:innodb_lock_wait_timeout]           = '5'
default[:mysql][:tunable][:query_cache_size]                   = '16M'
default[:mysql][:tunable][:query_cache_limit]                  = '100K'
default[:mysql][:tunable][:max_allowed_packet]                 = '32M'
default[:mysql][:tunable][:slave_max_allowed_packet]           = '32M'
default[:mysql][:tunable][:event_scheduler]                    = 'OFF'
default[:mysql][:tunable][:group_concat_max_len]               = '1024'
default[:mysql][:tunable][:replicate_wild_do_table]            = ' '
default[:mysql][:tunable][:replicate_ignore_table]             = ' '
default[:mysql][:tunable][:tmp_table_size]                     = '16M'
default[:mysql][:tunable][:tmp_dir]                            = '/var/tmp'
default[:mysql][:tunable][:max_heap_table_size]                = '256M'
default[:mysql][:tunable][:expire_log_days]                    = '3'
default[:mysql][:tunable][:binlog_format]                      = 'MIXED'
default[:mysql][:tunable][:character_set_server]               = 'utf8'
default[:mysql][:tunable][:collation_server]                   = 'utf8_unicode_ci'
default[:mysql][:tunable][:log_queries_not_using_indexes]      = 'OFF'
default[:mysql][:tunable][:transaction_isolation]              = 'REPEATABLE-READ'
default[:mysql][:tunable][:auto_increment_increment]           = '1'
default[:mysql][:tunable][:auto_increment_offset]              = '1'
default[:mysql][:tunable][:thread_stack]                       = '128K'
default[:mysql][:tunable][:slave_type_conversions]             = 'ALL_NON_LOSSY'
default[:mysql][:tunable][:query_cache_type]                   = 'ON'
default[:mysql][:tunable][:query_cache_size]                   = '16M'
default[:mysql][:tunable][:query_cache_limit]                  = '4096'
default[:mysql][:tunable][:query_cache_min_res_unit]           = '512'
default[:mysql][:tunable][:table_open_cache]                   = '1024'
default[:mysql][:tunable][:table_definition_cache]             = '1024'
default[:mysql][:tunable][:replicate_wild_do_table]            = ' '
default[:mysql][:tunable][:replicate_ignore_table]             = ' '
default[:mysql][:tunable][:innodb_flush_log_at_trx_commit]     = '1'
default[:mysql][:tunable][:sync_binlog]                        = '0' 

# Backup attributes
default[:mysql][:backup][:retention_period]                    = '7'
default[:mysql][:backup][:crontab_schedule]                    = %w(0 8 * * *)

