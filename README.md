# ssh-proxy

**ssh-proxy** is a dockerized SSH server for SOCKS5 proxy

## Quickstart

### at client.example.com

Install Docker and clone **ssh-proxy-client**.

    git clone https://github.com/nikat/ssh-proxy-client.git
    cd ssh-proxy-client
    cp ssh_config.sample ssh_config

Set server hostname in **ssh_config**
    
    Hostname server.example.com

Create the keys

    ssh-keygen -b 2048 -t rsa -f ./id_rsa -q -N ""


### at server.example.com

Install Docker and clone **ssh-proxy** server.

    git clone https://github.com/nikat/ssh-proxy.git
    cd ssh-proxy

Copy text from `client.example.com:~/ssh-proxy-client/id_rsa.pub` and append it to `server.example.com:~/ssh-proxy/authorized_keys`.  Repeat if there are other clients.
 
Run the server

    ./run.sh up

### at client.example.com

Run the client

    ./run.sh up

Check the proxy. This command should output server's ip address

    curl --socks5-hostname 127.0.0.1:11050 ifconfig.me
