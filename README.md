# utm_le_updater
Updater Script for Dehydrated + Sophos UTM

This is my hacked together updater script for a ubuntu (or docker container) using dehydrated.

Its beeing run from /etc/dehydrated/certs/yourdomain.com and uses the sophos certificate update script (utm_update_certificate.pl) from m.bunkus https://github.com/mbunkus/utm-update-certificate

quick'n'dirty:

1. Upload Lets Encrypt Certificate Authority https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem and import that to your sophos
2. Create a Ubuntu based (other distros should work) machine (i used a docker container) with dehydrated that pulls certs for your domain
    i used the excellent tutorial from Benjamin Bryan, using Dehydrated and dns-01 challenge for lets encrypt --> https://b3n.org/intranet-ssl-certificates-using-lets-encrypt-dns-01/
3. Make some ssh-keys and put the pub key into your sophos to access loginuser (need root once to get cert REF names)
4. edit the copycerts.sh to your needs (ip, domain etc and most important the REF IDs to your own Cert and lets encrypt CA, see https://www.linet-services.de/sophos-utm-lets-encrypt-automatische-zertifikatsupdates/)
5. let dehydrate get your certs
5. put the utm_update-certificate.pl script in the same dir as the updater script
6. run ./copycerts.sh (this will upload the nessesary files, run the cert updater and than delete everything aftwards)
7. should now have your lets encrypt certs
    
