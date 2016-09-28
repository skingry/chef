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
$vagrant[:cpus] = 2
$vagrant[:memory_size] = 2048
$vagrant[:ioapic] = 'on'

