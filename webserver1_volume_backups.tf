resource "oci_core_boot_volume_backup" "FoggyKitchenWebserver1BootVolumeBackupFull" {
    depends_on = [oci_functions_function.FoggyKitchenUpdateTagForBootVolumeBackupFn,oci_events_rule.FoggyKitchenUpdateTagForBootVolumeBackupTrigger]
    boot_volume_id = oci_core_instance.FoggyKitchenWebserver1.boot_volume_id 
    display_name = "FoggyKitchenWebserver1BootVolumeBackupFull"
    type = "FULL"
}


resource "oci_core_volume_backup" "FoggyKitchenWebserver1BlockVolume50GBackupFull" {
    depends_on = [oci_functions_function.FoggyKitchenUpdateTagForVolumeBackupFn,oci_events_rule.FoggyKitchenUpdateTagForVolumeBackupTrigger]
    volume_id = oci_core_volume.FoggyKitchenWebserver1BlockVolume50G.id 
    display_name = "FoggyKitchenWebserver1BlockVolume50GBackupFull"
    type = "FULL"
}

