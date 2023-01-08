# Mount-Object-Storage-on-Linux


## Usage
1) The script mounts object storage on Linux/Ubuntu OS directory. Object storage by various provideers include: <br>
    - Amazon S3 (aws_s3) <br>
    - Linode Object Storage (linode_objs) <br>
    - Backblaze Cloud Storage (b2_cs) <br>
    - Google Cloud Storage (gcp_cs) <br>
    - CrowdStorage Object Storage (PolyCloud, crd_objs)  <br>
    - Azure Blob Storage (Azure_objs <br>
    - etc. <br>


## TO run the Bash script

1) #### Download or clone the following fils, from this repo, into the current working directory (CWD) on the Linux/Ubuntu OS machine: <br>
   - Bash script - mount-object-storage.sh<br>
   
2) #### Fill in relevant input variables (line 22-27 of the script) at the top of the script including: <br>
   - clean_system_confirm
   - mount_storage_confirm
   - mount_dir
   - bucket_name
   - provider_url
   - credentials

4) #### Then set permssion on the script and run the script, assuming sudo access: <br>
   - set permission <br>
   sudo chmod +x mount-object-storage.sh
   - run <br>
   ./mount-object-storage.sh


# License

Copyright © 2015 - present. MongoExpUser

Licensed under the MIT license.
