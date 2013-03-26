Vagrant::Config.run do |config|

  # Razor Server
  config.vm.define :razor do |r|
    r.vm.box = "quantal"
    r.vm.box_url = "http://cloud-images.ubuntu.com/quantal/current/quantal-server-cloudimg-vagrant-amd64-disk1.box"

    r.vm.provision :puppet, :module_path => "modules"

    # Run puppet twice; No joke. This is required due to a bug in the rz_tag
    # resource which will only make the tag on the first run, and then the tag
    # matchers on the second.
    r.vm.provision :puppet, :module_path => "modules"

    r.vm.network :hostonly, "10.0.1.50", :netmask => "255.255.255.0", :adapter => 2
    r.vm.customize ["modifyvm", :id, "--cpus", `grep '^processor	' /proc/cpuinfo | wc -l`.chomp, "--ioapic", "on"]
  end

  # Test VM
  config.vm.define :test do |r|
    r.vm.box = "pxe-blank"
    r.vm.box_url = "https://github.com/downloads/benburkert/bootstrap-razor/pxe-blank.box"

    r.vm.boot_mode = :gui
    r.vm.network :hostonly, "10.0.1.51", :netmask => "255.255.255.0", :adapter => 1

    r.vm.provision :shell, :inline => ""
    r.vm.customize ["modifyvm", :id, "--boot1", "net"]
    r.vm.customize ["modifyvm", :id, "--nictype1", 'Am79C973']
    r.vm.customize ["modifyvm", :id, "--cpus", `grep '^processor	' /proc/cpuinfo | wc -l`.chomp, "--ioapic", "on"]
  end

  # Ubuntu Precise VM (Will boot and install automatically.)
  config.vm.define :"ubuntu-precise" do |r|
    r.vm.box = "pxe-blank"
    r.vm.box_url = "https://github.com/downloads/benburkert/bootstrap-razor/pxe-blank.box"

    r.vm.host_name = "ubuntu-precise"
    r.vm.boot_mode = :gui
    r.vm.network :hostonly, "10.0.1.52", :netmask => "255.255.255.0", :adapter => 1

    r.vm.provision :shell, :inline => ""
    r.vm.customize ["modifyvm", :id, "--boot1", "net"]
    r.vm.customize ["modifyvm", :id, "--nictype1", 'Am79C973']
    r.vm.customize ["modifyvm", :id, "--cpus", `grep '^processor	' /proc/cpuinfo | wc -l`.chomp, "--ioapic", "on"]
    r.vm.customize ["guestproperty", "set", :id, "vagrant_os", "ubuntu-precise"]
  end

  # CentOS 6 VM (Will boot and install automatically.)
  config.vm.define :"centos-6" do |r|
    r.vm.box = "pxe-blank"
    r.vm.box_url = "https://github.com/downloads/benburkert/bootstrap-razor/pxe-blank.box"

    r.vm.host_name = "centos-6"
    r.vm.boot_mode = :gui
    r.vm.network :hostonly, "10.0.1.53", :netmask => "255.255.255.0", :adapter => 1

    r.vm.provision :shell, :inline => ""
    r.vm.customize ["modifyvm", :id, "--boot1", "net"]
    r.vm.customize ["modifyvm", :id, "--nictype1", 'Am79C973']
    r.vm.customize ["modifyvm", :id, "--cpus", `grep '^processor	' /proc/cpuinfo | wc -l`.chomp, "--ioapic", "on"]
    r.vm.customize ["guestproperty", "set", :id, "vagrant_os", "centos-6"]
  end

end
