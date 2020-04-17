resource "oci_core_boot_volume_backup" "FoggyKitchenWebserver1BootVolumeBackupFull" {
    boot_volume_id = oci_core_instance.FoggyKitchenWebserver1.boot_volume_id 
    display_name = "FoggyKitchenWebserver1BootVolumeBackupFull"
    type = "FULL"
}


resource "oci_core_boot_volume_backup" "FoggyKitchenWebserver1BootVolumeBackupIncremental1" {
    boot_volume_id = oci_core_instance.FoggyKitchenWebserver1.boot_volume_id  
    display_name = "FoggyKitchenWebserver1BootVolumeBackupIncremental1"
    type = "INCREMENTAL"
}

resource "oci_core_volume_backup" "FoggyKitchenWebserver1BlockVolume50GBackupFull" {
    volume_id = oci_core_volume.FoggyKitchenWebserver1BlockVolume50G.id 
    display_name = "FoggyKitchenWebserver1BlockVolume50GBackupFull"
    type = "FULL"
}

resource "oci_core_volume_backup" "FoggyKitchenWebserver1BlockVolume50GBackupIncremental1" {
    volume_id = oci_core_volume.FoggyKitchenWebserver1BlockVolume50G.id 
    display_name = "FoggyKitchenWebserver1BlockVolume50GBackupIncremental1"
    type = "INCREMENTAL"
}
