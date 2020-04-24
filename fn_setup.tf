resource "null_resource" "FoggyKitchenFnSetup" {
  depends_on = [oci_functions_application.FoggyKitchenFnApp]

  provisioner "local-exec" {
    command = "echo '${var.ocir_user_password}' |  docker login ${var.ocir_docker_repository} --username ${var.ocir_namespace}/${var.ocir_user_name} --password-stdin"
  }

  provisioner "local-exec" {
    command = "fn build"
    working_dir = "functions/UpdateTagForBootVolumeBackupFn"
  }

  provisioner "local-exec" {
    command = "docker push ${var.ocir_docker_repository}/${var.ocir_namespace}/${var.ocir_repo_name}/updatetagforbootvolumebackupfn:0.0.1"
    working_dir = "functions/UpdateTagForBootVolumeBackupFn"
  }

  provisioner "local-exec" {
    command = "fn build"
    working_dir = "functions/UpdateTagForVolumeBackupFn"
  }

  provisioner "local-exec" {
    command = "docker push ${var.ocir_docker_repository}/${var.ocir_namespace}/${var.ocir_repo_name}/updatetagforvolumebackupfn:0.0.1"
    working_dir = "functions/UpdateTagForVolumeBackupFn"
  }

}