# vagrant-geoserver-postgis
Vagrantfile and provisioner for a PostGIS/GeoServer box (running trusty64)

### Background

This is an attempt to provide an easy and replicatable way to rapidly stand up a GeoServer instance for development or other purposes in an automated way, using vagrant.

### Prerequisites:

**Vagrant**

Installation of vagrant https://www.vagrantup.com/ - vagrant provides the mechanism for configuring and provisioning the machine.  Vagrant can support VirtualBox or cloud hosted platforms.  This vagrant instance is initially focusing on virtualbox.

**VirtualBox**

The geoserver instance will run within virtualbox https://www.virtualbox.org/wiki/Downloads - vagrant will create a virtualbox vm and provision it

### Running the VM

With vagrant and virtualbox installed on the host machine, the GeoServer machine can be instantiated by cloning or copying this repo into a directory, and from a command line, going to the directory containing the vagrantfile and provision.sh scripts, and simply running 'vagrant up'

Vagrant will create the vm, and then will fetch Ubuntu 14.04 (trusty64) and then run the provisioner script.  The provisioner script, 'provision.sh' is just a BASH shell script that will run to install dependencies, and then install PostGIS and GeoServer.

Once it is up and running, the GeoServer instance should be accessible by going to http://localhost:8080/geoserver

The VM can be shut down by using 'vagrant halt' - and can be destroyed by using 'vagrant destroy' from the host machine command line.  The machine can also be accessed by using 'vagrant ssh' or via VirtualBox

### Post-Installation

After the VM is up, the user will want to change any relevant passwords and make appropriate changes...

This is currently still a work in progress - if there are system tweaks that are recommended, or ways to improve the provisioner bash script, please submit as changes.


