$vagrant[:name] = "Media Server"
$vagrant[:ssh_username] = "vagrant"
$vagrant[:hostname] = "monolith.media-server-testing.com"
$vagrant[:hostname_aliases] = [ "couchpotato.media-server-testing.com", 
                                "plex.media-server-testing.com", 
                                "plexpy.media-server-testing.com", 
                                "sabnzbd.media-server-testing.com", 
                                "sonarr.media-server-testing.com", 
                                "transmission.media-server-testing.com" ]
$vagrant[:main_ip] = "192.168.56.101"
$vagrant[:cpus] = 4
$vagrant[:memory_size] = 4096
$vagrant[:ioapic] = 'off'

