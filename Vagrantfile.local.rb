domain = "media-server.local"

$vagrant[:name] = "Media Server"
$vagrant[:ssh_username] = "vagrant"
$vagrant[:hostname] = "monolith.#{domain}"
$vagrant[:hostname_aliases] = [ "couchpotato.#{domain}",
                                "plex.#{domain}",
                                "plexpy.#{domain}",
                                "sabnzbd.#{domain}",
                                "sonarr.#{domain}",
                                "transmission.#{domain}" ]
$vagrant[:main_ip] = "192.168.56.101"
$vagrant[:cpus] = 4
$vagrant[:memory_size] = 4096
$vagrant[:ioapic] = 'on'

