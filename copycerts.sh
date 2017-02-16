#!/bin/bash                                                                                                                                              
                                                                                                                                                         
domain=foo-bar.com                                                                                                                                        
sophos_ip=192.168.1.100                                                                                                                                   
cert=REF_.........                                                                                                                                 
certca_le=REF_.......                                                                                                                      
pk12password=test1234                                                                                                                                    
                                                                                                                                                         
rm *.pk12                                                                                                                                                
openssl pkcs12 -export -out ${domain}.pk12 -in cert.pem -inkey privkey.pem -name Cert-Name -password pass:${pk12password}                                
echo "Certificate converted to .pk12 format"                                                                                                             
ssh loginuser@${sophos_ip} "mkdir /home/login/le-cert-${domain}/"                                                                                        
echo "created directory"                                                                                                                                 
sleep 2                                                                                                                                                  
scp ${domain}.pk12 cert.pem privkey.pem chain.pem loginuser@${sophos_ip}:/home/login/le-cert-${domain}                                                   
#ssh loginuser@${sophos_ip} "mkdir home/login/le-cert-${domain}/"                                                                                        
scp utm_update_certificate.pl loginuser@${sophos_ip}:/home/login/le-cert-${domain}/                                                                      
echo "Certificate should now be available at /home/login/ on the sophos utm"                                                                             
#cp ${domain}.pk12 /Certs/                                                                                                                               
#echo "extra copy to /Certs !"                                                                                                                           
echo "now we are going to update the cert on the utm via that script we uploaded ...."                                                                   
ssh loginuser@${sophos_ip} << EOF                                                                                                                        
        cd /home/login/le-cert-${domain}/;                                                                                                               
        chmod +x utm_update_certificate.pl                                                                                                               
        ./utm_update_certificate.pl ${cert} cert.pem privkey.pem ${certca_le} chain.pem                                                                  
        rm -R /home/login/le-cert-${domain}                                                                                                              
        EOF                                                                                                                                              
#echo "all cleaned up"                                                                                                                                   
echo "all done"
