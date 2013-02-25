Add your razor OS isos here. They will automatically be made available to your
razor server at /vagrant/isos. They can then be imported into your razor
instance:

    # razor image add --type os --path \
      /vagrant/isos/ubuntu-12.04.1-server-amd64.iso --name ubuntu_precise \
      --version 12.04.1
