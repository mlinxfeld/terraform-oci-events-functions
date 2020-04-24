resource "oci_core_instance" "FoggyKitchenWebserver1" {
  depends_on = [oci_identity_tag_namespace.FoggyKitchenTagNamespace,oci_identity_tag.FoggyKitchenTag,oci_identity_tag.FoggyKitchenTag2]
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[1], "name")
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name = "FoggyKitchenWebServer1"
  shape = var.Shapes[0]
  subnet_id = oci_core_subnet.FoggyKitchenPublicSubnet.id
  source_details {
    source_type = "image"
    source_id   = lookup(data.oci_core_images.OSImageLocal.images[0], "id")
  }
  metadata = {
      ssh_authorized_keys = file(var.public_key_oci)
  }
  create_vnic_details {
     subnet_id = oci_core_subnet.FoggyKitchenPublicSubnet.id
     assign_public_ip = true
     nsg_ids = [oci_core_network_security_group.FoggyKitchenSSHSecurityGroup.id]
  }
  defined_tags = {"${oci_identity_tag_namespace.FoggyKitchenTagNamespace.name}.${oci_identity_tag.FoggyKitchenTag.name}" = "mytagvalue1", "${oci_identity_tag_namespace.FoggyKitchenTagNamespace.name}.${oci_identity_tag.FoggyKitchenTag2.name}" = "mytagvalue2" }
}

data "oci_core_vnic_attachments" "FoggyKitchenWebserver1_VNIC1_attach" {
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[1], "name")
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  instance_id = oci_core_instance.FoggyKitchenWebserver1.id
}

data "oci_core_vnic" "FoggyKitchenWebserver1_VNIC1" {
  vnic_id = data.oci_core_vnic_attachments.FoggyKitchenWebserver1_VNIC1_attach.vnic_attachments.0.vnic_id
}

output "FoggyKitchenWebserver1_PublicIP" {
   value = [data.oci_core_vnic.FoggyKitchenWebserver1_VNIC1.public_ip_address]
}

