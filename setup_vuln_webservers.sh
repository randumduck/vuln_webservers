#!/bin/bash

# Update and install necessary packages
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y docker.io docker-compose bind9

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Create Docker network with Class A private IP range
sudo docker network create --subnet=10.0.0.0/8 vuln_network

# Create a directory for DNS configuration
mkdir -p ~/dns
cd ~/dns

# Create named.conf.local for DNS zones
cat <<EOF > named.conf.local
zone "vuln.test" {
    type master;
    file "/etc/bind/db.vuln.test";
};
EOF

# Create DNS zone file
cat <<EOF > db.vuln.test
\$TTL    604800
@       IN      SOA     ns.vuln.test. root.vuln.test. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns.vuln.test.
ns      IN      A       10.0.0.2
EOF

# Add DNS entries for each web server
for i in {1..5}; do
    echo "web$i    IN      A       10.0.0.$((i+2))" >> db.vuln.test
done

# Copy DNS configuration to bind directory
sudo cp named.conf.local /etc/bind/
sudo cp db.vuln.test /etc/bind/

# Restart bind9 service
sudo systemctl restart bind9

# Create Docker containers with vulnerable web servers
for i in {1..5}; do
    sudo docker run -d --name web$i --network vuln_network --ip 10.0.0.$((i+2)) -h web$i.vuln.test -v /var/www/html/web$i:/usr/local/apache2/htdocs/ httpd:2.4.29
done

# Create index.html for each web server
for i in {1..5}; do
    mkdir -p /var/www/html/web$i
    cat <<EOF > /var/www/html/web$i/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Web Server $i</title>
</head>
<body>
    <h1>Web Server $i</h1>
    <p>Hostname: web$i.vuln.test</p>
    <p>IP Address: 10.0.0.$((i+2))</p>
    <p>Web Server Version: Apache 2.4.29</p>
    <p>Docker Image: httpd:2.4.29</p>
</body>
</html>
EOF
done

# Create a text file with web server details
cat <<EOF > ~/Desktop/web_servers_info.txt
Web Server Details:
-------------------
EOF

for i in {1..5}; do
    echo "web$i.vuln.test - 10.0.0.$((i+2)) - Apache 2.4.29 - Docker Image: httpd:2.4.29" >> ~/Desktop/web_servers_info.txt
done

echo "Setup complete. Web server details saved to ~/Desktop/web_servers_info.txt"
