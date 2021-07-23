# // Step 1 : Spin up an Ubuntu instance then create a new shell script and give it executable permissions:

touch bambooSetup.sh && chmod +x bambooSetup.sh
								
#// Step 2: Script - paste it into bambooSetup.sh 

#!/usr/bin/env bash

sudo apt-get update -y
sudo apt install openjdk-8-jdk-headless -y
sudo /usr/sbin/useradd --create-home --home-dir /usr/local/bamboo --shell /bin/bash bamboo
sudo mkdir /opt/bamboofiles
cd /opt
sudo wget https://product-downloads.atlassian.com/software/bamboo/downloads/atlassian-bamboo-7.0.2.tar.gz
sudo tar -xf /opt/atlassian-bamboo-7.0.2.tar.gz
sudo mv atlassian-bamboo-7.0.2 bamboo
# Set Bamboo Home which is NOT the same as the install directory
echo "bamboo.home=/opt/bamboofiles" | sudo tee --append /opt/bamboo/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties > /dev/null
sudo chown -R bamboo: /opt/bamboo
sudo chown -R bamboo: /opt/bamboofiles
sudo -H -u bamboo /opt/bamboo/bin/start-bamboo.sh
echo ""
echo "================================================================"
echo "Bamboo Started!"
echo "Bamboo Available at: http://$(curl -s http://255.255.255.255/latest/meta-data/public-ipv4):8085"
echo "================================================================"
echo ""
