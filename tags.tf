resource "oci_identity_tag_namespace" "FoggyKitchenTagNamespace" {
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    description = "FoggyKitchenTagNamespace"
    name = "FoggyKitchenTagNamespace"
}

resource "oci_identity_tag" "FoggyKitchenTag" {
    description = "FoggyKitchenTag"
    name = "FoggyKitchenTag"
    tag_namespace_id = oci_identity_tag_namespace.FoggyKitchenTagNamespace.id
}

resource "oci_identity_tag" "FoggyKitchenTag2" {
    description = "FoggyKitchenTag"
    name = "FoggyKitchenTag2"
    tag_namespace_id = oci_identity_tag_namespace.FoggyKitchenTagNamespace.id
}