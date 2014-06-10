#
# Author:: Adam Jacob (<adam@opscode.com>)
# Author:: Seth Falcon (<seth@opscode.com>)
# Author:: Kenneth Vestergaard (<kenneth.vestergaard@shopify.com>)
#
# Copyright:: Copyright (c) 2009-2010 Opscode, Inc.
# License:: Apache License, Version 2.0
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

require 'chef/knife/data_bag_edit'

class Chef
  class Knife
    class DataBagEdit
      def use_encryption
        unless config[:secret_file]
          stdout.puts "Please specify --secret-file"
          exit(1)
        end
        config[:secret_file]
      end

      def load_item(file, id)
        item = encrypted = nil

        if File.exist?(file)
          raw  = JSON.parse(File.read(file))
          bag  = Chef::DataBagItem.from_hash(raw)
          item = Chef::EncryptedDataBagItem.new(bag, read_secret).to_hash
        else
          raw  = {}
          item = Chef::DataBagItem.new
          item['id'] = id
        end

        data = item.to_hash.delete_if { |k| %w(chef_type data_bag).include?(k) }
        [data, raw]
      end

      def run
        if Chef::Config[:data_bag_path].empty?
          stdout.puts "Please specify 'data_bag_path' in your 'knife.rb'"
          exit 1
        end

        if @name_args.length != 2
          stdout.puts "You must supply the data bag item file to edit!"
          stdout.puts opt_parser
          exit 1
        end

        item_dir = "#{Chef::Config[:data_bag_path]}/#{@name_args[0]}"
        FileUtils.mkdir(item_dir) unless Dir.exist?(item_dir)
        file = "#{item_dir}/#{@name_args[1]}.json"

        old_data, old_encrypted = load_item(file, @name_args[1])
        new_data = edit_data(old_data)

        unless new_data == old_data
          data = reencrypt(new_data, old_data, old_encrypted, read_secret)
          output = Chef::JSONCompat.to_json_pretty(data)

          File.open(file, 'w') { |f| f.puts output }
          save_message(file)
          ui.output(output) if config[:print_after]
        end
      end

      def save_message(file)
        stdout.puts("Saved #{file}")
      end

      def reencrypt(new, old, encrypted, secret)
        pairs = new.map do |key, new_value|
          if key == 'id'
            [key, new_value]
          else
            old_value     = old[key]
            old_encrypted = encrypted[key]

            new_encrypted = old_encrypted if new_value == old_value
            new_encrypted ||= Chef::EncryptedDataBagItem::Encryptor.new(new_value, secret).for_encrypted_item

            [key, new_encrypted]
          end
        end

        Hash[pairs]
      end
    end
  end
end
