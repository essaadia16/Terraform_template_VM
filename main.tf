data "vsphere_datacenter" "datacenter" {
  name = "datacenter"
}

data "vsphere_compute_cluster" "cluster" {
   name            = "cluster"
    datacenter_id   = data.vsphere_datacenter.datacenter.id
    #host_system_ids = [ vsphere_host.ESXi1.id, vsphere_host.ESXi2.id ]


}
data "vsphere_datastore" "datastore2" {
  datacenter_id = data.vsphere_datacenter.datacenter.id
  name = "datastore1"

}
data "vsphere_datastore" "datastore1" {
 datacenter_id = data.vsphere_datacenter.datacenter.id
  name = "datastore1 (1)"

}

data "vsphere_network" "network" {
  name = "VM Network"
   datacenter_id = data.vsphere_datacenter.datacenter.id
}


data "vsphere_virtual_machine" "VM-Template" {
  name          = "VM-Template"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "VM-Ansible" {
  name             = "VM-Ansible"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore2.id
  num_cpus         = 2
  memory           = 1024        

  guest_id         = data.vsphere_virtual_machine.VM-Template.guest_id


  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.VM-Template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.VM-Template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.VM-Template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.VM-Template.id
    customize {
      linux_options {
        host_name = "VM-Ansible"
        domain    = "local"
      }
      network_interface {
        ipv4_address = "192.168.19.14"
        ipv4_netmask = 24
      }
    } 
  }
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0
 }

resource "vsphere_virtual_machine" "VM-Jenkins" {
  name             = "VM-Jenkins"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore2.id
  num_cpus         = 2
  memory           = 1024        

  guest_id         = data.vsphere_virtual_machine.VM-Template.guest_id


  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.VM-Template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.VM-Template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.VM-Template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.VM-Template.id
    customize {
      linux_options {
        host_name = "VM-Jenkins"
        domain    = "local"
      }
      network_interface {
        ipv4_address = "192.168.19.16"
        ipv4_netmask = 24
      }
    } 
  }
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0
 }
 
resource "vsphere_virtual_machine" "VM-Deploy" {
  name             = "VM-Deploy"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore2.id
  num_cpus         = 2
  memory           = 1024        

  guest_id         = data.vsphere_virtual_machine.VM-Template.guest_id


  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.VM-Template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.VM-Template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.VM-Template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.VM-Template.id
    customize {
      linux_options {
        host_name = "VM-Deploy"
        domain    = "local"
      }
      network_interface {
        ipv4_address = "192.168.19.18"
        ipv4_netmask = 24
      }
    } 
  }
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0
}
 