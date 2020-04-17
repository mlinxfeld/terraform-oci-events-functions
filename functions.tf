resource "oci_functions_application" "FoggyKitchenFnApp" {
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    display_name = "FoggyKitchenFnApp"
    subnet_ids = [oci_core_subnet.FoggyKitchenPublicSubnet.id]
}

resource "oci_functions_function" "FoggyKitchenUpdateTagForBootVolumeBackupFn" {
    application_id = oci_functions_application.FoggyKitchenFnApp.id
    display_name = "FoggyKitchenUpdateTagForBootVolumeBackupFn"
    image = "fra.ocir.io/fr5tvfiq2xhq/mlinxfeld/updatetagforbootvolumebackupfn:0.0.22"
    memory_in_mbs = "256" # memoryInMBs should be a MB value that is one of the supported shapes (128, 256, 512, 1024)
}

resource "oci_functions_function" "FoggyKitchenUpdateTagForVolumeBackupFn" {
    application_id = oci_functions_application.FoggyKitchenFnApp.id
    display_name = "FoggyKitchenUpdateTagForVolumeBackupFn"
    image = "fra.ocir.io/fr5tvfiq2xhq/mlinxfeld/updatetagforvolumebackupfn:0.0.2"
    memory_in_mbs = "256" # memoryInMBs should be a MB value that is one of the supported shapes (128, 256, 512, 1024)
}