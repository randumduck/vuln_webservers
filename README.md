# vuln_webservers
Sets up 5 Docker containers with different vulnerable web servers. Each web server's homepage will display the hostname, IP address, web server version, and Docker image info.


Here's a `README.md` file for your script, along with a suggested name for the script file.

### Script Name
You can name the script `setup_vuln_webservers.sh`.

### README.md
```markdown
# Vulnerable Web Servers Setup Script

This repository contains a bash script to set up five vulnerable web servers on an Ubuntu machine using Docker. Each web server runs a different vulnerable version of common web applications, allowing you to practice penetration testing and security assessments.

## Prerequisites

- Ubuntu machine (preferably a fresh installation)
- Internet connection
- Sufficient disk space and memory
- Basic knowledge of using the terminal

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/vulnmachine.git
   cd vulnmachine
   ```

2. **Make the script executable**:
   ```bash
   chmod +x setup_vuln_webservers.sh
   ```

3. **Run the script**:
   ```bash
   sudo ./setup_vuln_webservers.sh
   ```

## What the Script Does

1. **System Update and Upgrade**:
   - Updates and upgrades the system packages to ensure everything is up-to-date.

2. **Installs Necessary Packages**:
   - Installs Docker, Docker Compose, and BIND9 for DNS configuration.

3. **Docker Network Creation**:
   - Creates a Docker network with a Class A private IP range to isolate the web servers.

4. **DNS Configuration**:
   - Sets up a DNS server using BIND9 and configures DNS entries for the web servers with the domain `*.vuln.test`.

5. **Docker Containers**:
   - Creates 5 Docker containers, each running Apache 2.4.29 (a vulnerable version).

6. **Web Server Homepages**:
   - Configures each web server's homepage to display the hostname, IP address, web server version, and Docker image info.

7. **Web Server Details**:
   - Generates a text file on the desktop with the details of each web server, including hostname, IP address, web server version, and Docker image info.

## Usage

After running the script, your Ubuntu machine will have five Docker containers running vulnerable web servers. You can access these web servers using their DNS names (e.g., `web1.vuln.test`) from any VM or machine configured to use the DNS server.

### Example DNS Configuration for VMs

To access the web servers from VMs running on a Class C IP range, configure the VMs to use the Ubuntu machine as their DNS server. You can do this by editing the network settings of the VMs and setting the DNS server to the IP address of the Ubuntu machine.

## Web Server Details

The script creates a text file on the desktop named `web_servers_info.txt` with the following details:

```
Web Server Details:
-------------------
web1.vuln.test - 10.0.0.3 - Apache 2.4.29 - Docker Image: httpd:2.4.29
web2.vuln.test - 10.0.0.4 - Apache 2.4.29 - Docker Image: httpd:2.4.29
web3.vuln.test - 10.0.0.5 - Apache 2.4.29 - Docker Image: httpd:2.4.29
web4.vuln.test - 10.0.0.6 - Apache 2.4.29 - Docker Image: httpd:2.4.29
web5.vuln.test - 10.0.0.7 - Apache 2.4.29 - Docker Image: httpd:2.4.29
```

## Disclaimer

This script is intended for educational purposes only. Use it in a controlled and isolated environment. Do not use it on production systems or networks without proper authorization.

## Contributing

If you have suggestions or improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
