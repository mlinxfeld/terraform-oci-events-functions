resource "oci_core_subnet" "FoggyKitchenPublicSubnet" {
  cidr_block = "10.0.1.0/24"
  display_name = "FoggyKitchenPublicSubnet"
  dns_label = "FoggyKitchenN1"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
  dhcp_options_id = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
}


