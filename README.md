electric-razor
==============

Electric Razor: Automatically setup razor server for your shaving pleasure.

Bring up the razor server.

    vagrant up razor

Once the razor server is up, bring up the test box.

    vagrant up test

You should be able to see the test box register in the test box's gui. You'll
also be able to see it on the razor server:

    vagrant ssh razor
    $ sudo -i
    # razor node
    Discovered Nodes
             UUID           Last Checkin  Status                           Tags                            
    2KtYvLedk358pLG5Z2rL17  2 sec         A       [memsize_500MiB,virtualbox_vm,OracleCorporation,nics_2]  

For those who need a VM up and fast two additional VM targets are provided:
'centos-6' and 'ubuntu-precise'. These VMs have been tagged appropriately and
will /automatically/ get their os installed. No tutorial to follow; No
commands to cut and paste. The necessary razor setup can be found in
manifests/default.pp for the interested.

    vagrant up centos-6
    vagrant up ubuntu-precise

credits
=======

A special thanks to benburkert whose work on razor-vagrant-demo was
inspirational: https://github.com/benburkert/razor-vagrant-demo
