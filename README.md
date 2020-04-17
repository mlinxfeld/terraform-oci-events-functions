# Terraform OCI Jitsi Meet

## Project description

In this repository I have documented my hands-on experience with Terrafrom for the purpose of Jitsi Meet installation in OCI. This set of HCL based Terraform files can customized according to any requirements.  

## Topology Diagram 

With the usage of this example HCL code you can build topology documented by diagram below. 

![](terraform-oci-jitsi-meet.jpg)

## How to use code 

### STEP 1.

Clone the repo from github by executing the command as follows and then go to terraform-oci-private-atp directory:

```
[opc@terraform-server ~]$ git clone https://github.com/mlinxfeld/terraform-oci-jitsi-meet.git
Cloning into 'terraform-oci-jitsi-meet'...
remote: Enumerating objects: 19, done.
remote: Counting objects: 100% (45/45), done.
remote: Compressing objects: 100% (31/31), done.
remote: Total 19 (delta 19), reused 19 (delta 14), pack-reused 0
Unpacking objects: 100% (19/19), done.

[opc@terraform-server ~]$ cd terraform-oci-jitsi-meet/

[opc@terraform-server terraform-oci-jitsi-meet]$ ls -latr
total 1044
-rw-r--r--   1 opc opc    185 14 kwi 18:31 compartment.tf
-rw-r--r--   1 opc opc    250 14 kwi 18:31 internet_gateway.tf
-rw-r--r--   1 opc opc    229 14 kwi 18:31 provider.tf
-rw-r--r--   1 opc opc    431 14 kwi 18:31 route.tf
-rw-r--r--   1 opc opc    438 14 kwi 18:35 subnet1.tf
-rw-r--r--   1 opc opc    530 14 kwi 18:39 security_group.tf
-rw-r--r--   1 opc opc    514 14 kwi 19:12 vcn.tf
drwxr-xr-x   3 opc opc     96 14 kwi 19:21 .terraform
-rw-r--r--   1 opc opc    414 14 kwi 19:22 dhcp_options.tf
-rwxr-xr-x   1 opc opc   1609 14 kwi 19:23 jitsi-meet-server.tf
-rw-r--r--   1 opc opc   1748 14 kwi 19:28 security_group_rules.tf
drwxr-xr-x  38 opc opc   1216 14 kwi 19:30 ..
-rw-r--r--   1 opc opc    193 14 kwi 20:15 jitsi-meet-answer2.sh
-rw-r--r--   1 opc opc    681 14 kwi 20:46 variables.tf
drwxr-xr-x  12 opc opc    384 14 kwi 21:00 .git
-rw-r--r--   1 opc opc   3669 15 kwi 10:14 jitsi-meet-provisioner.tf
-rw-r--r--   1 opc opc    158 15 kwi 10:19 terraform.tfstate.backup
-rw-r--r--   1 opc opc   8239 15 kwi 10:24 README.md
-rw-r--r--   1 opc opc  38173 15 kwi 10:25 terraform.tfstate
drwxr-xr-x  20 opc opc    640 15 kwi 10:25 .

```

### STEP 2.

Within web browser go to URL: https://www.terraform.io/downloads.html. Find your platform and download the latest version of your terraform runtime. Add directory of terraform binary into PATH and check terraform version:

```
[opc@terraform-server terraform-oci-jitsi-meet]$ export PATH=$PATH:/home/opc/terraform

[opc@terraform-server terraform-oci-jitsi-meet]$ terraform --version

Terraform v0.12.16

Your version of Terraform is out of date! The latest version
is 0.12.17. You can update by downloading from https://www.terraform.io/downloads.html
```

### STEP 3. 
Next create environment file with TF_VARs:

```
[opc@terraform-server terraform-oci-jitsi-meet]$ vi setup_oci_tf_vars.sh
export TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaaob4qbf2(...)uunizjie4his4vgh3jx5jxa"
export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaas(...)krj2s3gdbz7d2heqzzxn7pe64ksbia"
export TF_VAR_compartment_ocid="ocid1.tenancy.oc1..aaaaaaaasbktyckn(...)ldkrj2s3gdbz7d2heqzzxn7pe64ksbia"
export TF_VAR_fingerprint="00:f9:d1:41:bb:57(...)82:47:e6:00"
export TF_VAR_private_key_path="/tmp/oci_api_key.pem"
export TF_VAR_region="eu-frankfurt-1"
export TF_VAR_private_key_oci="/tmp/id_rsa"
export TF_VAR_public_key_oci="/tmp/id_rsa.pub"

[opc@terraform-server terraform-oci-jitsi-meet]$ source setup_oci_tf_vars.sh
```

### STEP 4.
Run *terraform init* with upgrade option just to download the lastest neccesary providers:

```
[opc@terraform-server terraform-oci-jitsi-meet]$ terraform init -upgrade

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "null" (hashicorp/null) 2.1.2...
- Downloading plugin for provider "local" (hashicorp/local) 1.4.0...
- Downloading plugin for provider "oci" (hashicorp/oci) 3.64.0...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.local: version = "~> 1.4"
* provider.null: version = "~> 2.1"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### STEP 5.
Run *terraform apply* to provision the content of this code (type **yes** to confirm the the apply phase):

```
[opc@terraform-server terraform-oci-jitsi-meet]$ terraform apply 

data.oci_core_images.OSImageLocal: Refreshing state...
data.oci_identity_availability_domains.ADs: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # data.oci_core_vnic.FoggyKitchenJitsiMeetServer_VNIC1 will be read during apply
  # (config refers to values not yet known)
 <= data "oci_core_vnic" "FoggyKitchenJitsiMeetServer_VNIC1"  {
      + availability_domain    = (known after apply)
      + compartment_id         = (known after apply)
(...)

Plan: 19 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

(...)

null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec): == 1. Verify Jitsi status
null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec): ● jitsi-videobridge2.service - Jitsi Videobridge
null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec):    Loaded: loaded (/lib/systemd/system/jitsi-videobridge2.service; enabled; vendor preset: enabled)
null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec):    Active: active (running) since Wed 2020-04-15 08:23:34 UTC; 1min 52s ago
null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec):   Process: 1318 ExecStartPost=/bin/bash -c echo $MAINPID > /var/run/jitsi-videobridge/jitsi-videobridge.pid (code=exited, status=0/SUCCESS)
null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec):  Main PID: 1317 (java)
null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec):     Tasks: 36 (limit: 65000)
null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec):    Memory: 232.6M
null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec):       CPU: 9.774s
null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec):    CGroup: /system.slice/jitsi-videobridge2.service
null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec):            └─1317 java -Xmx3072m -XX:+UseConcMarkSweepGC -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp -Dnet.java.sip.communicator.SC_HOME_DIR_LOCATION=/etc/jitsi -Dnet.java.sip.communicator.SC_HOME_DIR_NAME=videobridge -Dnet.java.sip.communicator.SC_LOG_DIR_LOCATION=/var/log/jitsi -Djava.util.logging.config.file=/etc/jitsi/videobridge/logging.properties -cp /usr/share/jitsi-videobridge/jitsi-videobridge.jar:/usr/share/jitsi-videobridge/lib/* org.jitsi.videobridge.Main --host=localhost --domain=130.61.74.35 --port=5347 --secret=fekHrM2s --apis=,

null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec): Apr 15 08:23:34 foggykitchenjitsimeetserver systemd[1]: Starting Jitsi Videobridge...
null_resource.FoggyKitchenJitsiMeetServerStatus (remote-exec): Apr 15 08:23:34 foggykitchenjitsimeetserver systemd[1]: Started Jitsi Videobridge.
null_resource.FoggyKitchenJitsiMeetServerStatus: Creation complete after 2s [id=4571849567579003760]

Apply complete! Resources: 19 added, 0 changed, 0 destroyed.

Outputs:

FoggyKitchenJitsiMeetServerPrivateIP = [
  "10.0.1.2",
]
FoggyKitchenJitsiMeetServerPublicIP = [
  "130.61.74.35",
]

(...)

```

### STEP 6.
Confirm that Jitsi Meet is accesible from public Internet (pick up Public IP from the step 5):

```
[opc@terraform-server terraform-oci-jitsi-meet]$ curl https://130.61.74.35/ -k | grep "APP_NAME"
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 35752    0 35752    0     0   180k      0 --:--:-- --:--:-- --:--:--  180k
    APP_NAME: 'Jitsi Meet',
    NATIVE_APP_NAME: 'Jitsi Meet',

[opc@terraform-server terraform-oci-jitsi-meet]$
```

Now you can go to the webbrowser and access it and use it :)


### STEP 7.
After testing the environment you can remove the whole OCI infra. You should just run *terraform destroy* (type **yes** for confirmation of the destroy phase):

```
[opc@terraform-server terraform-oci-jitsi-meet]$ terraform destroy

data.oci_identity_availability_domains.ADs: Refreshing state...
data.oci_core_images.OSImageLocal: Refreshing state...
oci_identity_compartment.FoggyKitchenCompartment: Refreshing state... [id=ocid1.compartment.oc1..aaaaaaaagillnk7ttj6wpdhmewpibpxc5gbmrfxdtmaa3gfgjzbudesm3tsq]
oci_core_virtual_network.FoggyKitchenVCN: Refreshing state... [id=ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaadngk4giatjvgzm5vu63qcmgcfiakuv2o3sjb6qvybpuq65a7mxaq]

(...)

Plan: 0 to add, 0 to change, 19 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

(...)

oci_core_network_security_group.FoggyKitchenSSHSecurityGroup: Destruction complete after 1s
oci_core_network_security_group.FoggyKitchenJitsiMeetSecurityGroup: Destruction complete after 2s
oci_core_virtual_network.FoggyKitchenVCN: Destroying... [id=ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaadngk4giatjvgzm5vu63qcmgcfiakuv2o3sjb6qvybpuq65a7mxaq]
oci_core_virtual_network.FoggyKitchenVCN: Destruction complete after 1s
oci_identity_compartment.FoggyKitchenCompartment: Destroying... [id=ocid1.compartment.oc1..aaaaaaaagillnk7ttj6wpdhmewpibpxc5gbmrfxdtmaa3gfgjzbudesm3tsq]
oci_identity_compartment.FoggyKitchenCompartment: Destruction complete after 0s

Destroy complete! Resources: 19 destroyed.

```
