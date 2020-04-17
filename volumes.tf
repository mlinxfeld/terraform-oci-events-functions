resource "oci_core_volume" "FoggyKitchenWebserver1BlockVolume50G" {
  depends_on = [oci_identity_tag_namespace.FoggyKitchenTagNamespace,oci_identity_tag.FoggyKitchenTag,oci_identity_tag.FoggyKitchenTag,oci_identity_tag.FoggyKitchenTag2]
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[1], "name")
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name = "FoggyKitchenWebserver1 BlockVolume 50G"
  size_in_gbs = "50"
  defined_tags = {"${oci_identity_tag_namespace.FoggyKitchenTagNamespace.name}.${oci_identity_tag.FoggyKitchenTag.name}" = "mytagvalue1", "${oci_identity_tag_namespace.FoggyKitchenTagNamespace.name}.${oci_identity_tag.FoggyKitchenTag2.name}" = "mytagvalue2"}
}

resource "oci_core_volume_attachment" "FoggyKitchenWebserver1BlockVolume50G_attach" {
    attachment_type = "iscsi"
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    instance_id = oci_core_instance.FoggyKitchenWebserver1.id
    volume_id = oci_core_volume.FoggyKitchenWebserver1BlockVolume50G.id
}

