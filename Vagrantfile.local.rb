$vagrant[:name] = "Media Server"
$vagrant[:ssh_username] = "skingry"
$vagrant[:hostname] = "monolith.robotozon.com"
$vagrant[:hostname_aliases] = [ "couchpotato.robotozon.com", 
                                "plex.robotozon.com", 
                                "plexpy.robotozon.com", 
                                "sabnzbd.robotozon.com", 
                                "sonarr.robotozon.com", 
                                "transmission.robotozon.com" ]
$vagrant[:main_ip] = "192.168.56.101"
$vagrant[:cpus] = 4
$vagrant[:memory_size] = 4096
$vagrant[:ioapic] = 'off'

