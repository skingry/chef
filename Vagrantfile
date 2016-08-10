# -*- mode: ruby -*-
# vi: set ft=ruby :

$vagrant = {}

# Override with local settings
local_file = "#{File.dirname(__FILE__)}/Vagrantfile.local.rb"
require local_file if File.exists?(local_file)

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false
  config.ssh.forward_agent = true
  config.ssh.username = $vagrant:ssh_username]
  config.vm.box = "robotozon/media-server"
  config.vm.box_url = "http://s3.robotozon.com/base_boxes/media-server.json"
  config.vm.network 'private_network', ip: $vagrant[:main_ip]
  config.vm.hostname = $vagrant[:hostname]
  config.hostsupdater.aliases = $vagrant[:hostname_aliases]
  config.vm.provider 'virtualbox' do |v|
    v.name = $vagrant[:name]
    v.customize [ 'modifyvm', :id, '--memory', $vagrant[:memory_size] ]
    v.customize [ 'modifyvm', :id, '--cpus', $vagrant[:cpus] ]
    v.customize [ 'modifyvm', :id, '--ioapic', $vagrant[:ioapic] ] # Note: this is buggy on older machines
    v.customize [ 'modifyvm', :id, '--natdnshostresolver1', 'on' ]

    # Set the timesync threshold to 5 seconds, instead of the default 20 minutes.
    v.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 5000]
  end
  config.vm.synced_folder '.', '/chef', :disabled => false
end

