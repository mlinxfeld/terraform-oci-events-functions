resource "oci_functions_application" "FoggyKitchenFnApp" {
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    display_name = "FoggyKitchenFnApp"
    subnet_ids = [oci_core_subnet.FoggyKitchenPublicSubnet.id]
}

resource "oci_functions_function" "FoggyKitchenUpdateTagForBootVolumeBackupFn" {
    depends_on = [null_resource.FoggyKitchenFnSetup]
    application_id = oci_functions_application.FoggyKitchenFnApp.id
    display_name = "FoggyKitchenUpdateTagForBootVolumeBackupFn"
    image = "${var.ocir_docker_repository}/${var.ocir_namespace}/${var.ocir_repo_name}/updatetagforbootvolumebackupfn:0.0.1"
    memory_in_mbs = "256" 
}

resource "oci_functions_function" "FoggyKitchenUpdateTagForVolumeBackupFn" {
    depends_on = [null_resource.FoggyKitchenFnSetup]
    application_id = oci_functions_application.FoggyKitchenFnApp.id
    display_name = "FoggyKitchenUpdateTagForVolumeBackupFn"
    image = "${var.ocir_docker_repository}/${var.ocir_namespace}/${var.ocir_repo_name}/updatetagforvolumebackupfn:0.0.1"
    memory_in_mbs = "256" 
}
