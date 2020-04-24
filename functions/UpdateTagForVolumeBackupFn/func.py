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
    volume_backup_ocid = body['data']['resourceId']
    volume_ocid = body['data']['additionalDetails']['volumeId']


    block_storage_client = oci.core.BlockstorageClient({}, signer=signer)
    try:
        v_json = block_storage_client.get_volume(volume_ocid).data

        vb_json = block_storage_client.update_volume_backup(
                        volume_backup_ocid, 
                        oci.core.models.UpdateVolumeBackupDetails(
                            freeform_tags={'new': 'freeform'}, 
                            defined_tags=v_json.defined_tags
                        )
        )
    except Exception as e:
        vb_json = str(e)
    return {"Result": "Success", }