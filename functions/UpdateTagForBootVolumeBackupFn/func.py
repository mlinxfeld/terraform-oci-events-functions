import io
import json
import oci
from fdk import response

def handler(ctx, data: io.BytesIO=None):
    signer = oci.auth.signers.get_resource_principals_signer()
    resp = do(signer, data)
    return response.Response(ctx,
        response_data=json.dumps(resp),
        headers={"Content-Type": "application/json"} )

def do(signer, data):
    body = json.loads(data.getvalue())
    boot_volume_backup_ocid = body['data']['resourceId']
    boot_volume_ocid = body['data']['additionalDetails']['volumeId']


    block_storage_client = oci.core.BlockstorageClient({}, signer=signer)
    try:
        bv_json = block_storage_client.get_boot_volume(boot_volume_ocid).data

        bvb_json = block_storage_client.update_boot_volume_backup(
                        boot_volume_backup_ocid, 
                        oci.core.models.UpdateBootVolumeBackupDetails(
                            freeform_tags={'new': 'freeform'}, 
                            defined_tags=bv_json.defined_tags
                        )
        )
    except Exception as e:
        bvb_json = str(e)
    return {"Result": "Success", }