#!/usr/bin/env bash

# go install github.com/ScriptTiger/Hosts-BL@latest to get bin in path
# don't want to reimplement --comments feature and don't want to maintain a separate whitelist

update_hosts() {
    # get sudo
    sudo -v

    before=$(wc -l /etc/hosts)

    # Download the file
    wget -O hosts.txt https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts

    # Run the command
    Hosts-BL -comments -f hosts hosts.txt /etc/hosts

    # Delete the file
    rm hosts.txt

    after=$(wc -l /etc/hosts)

    echo "Before: $before"
    echo "After: $after"
}
update_hosts
