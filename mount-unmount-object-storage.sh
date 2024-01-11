#!/bin/bash

#===================================================================================================================#
#                                                                                                                   #
#  @License Starts                                                                                                  #
#                                                                                                                   #
#  Copyright © 2015 - present. MongoExpUser.  All Rights Reserved.                                                  #
#                                                                                                                   #
#  License: MIT                                                                                                     #
#                                                                                                                   #
#  @License Ends                                                                                                    #
#                                                                                                                   #
#...................................................................................................................#
#                                                                                                                   #
# mount-unmount-object-storage.sh                                                                                   #
#===================================================================================================================#

# set permission on main directory
sudo chmod 775 /home

# define input variables
clean_system_confirm=true
mount_storage_confirm=true
unmount_storage_confirm=false
mount_dir="/path-to/my-dir"
bucket_name="my-bucket-name"
provider_url="my-provider-url" 
provider_credential="access_key_id:secret_access_key" 
# providers: aws, linode, gcp, backblaze, azure, oracle, do, vultr, scaleway, OVH, cloudflare, etc. 
# Check providers' web sites for urls and credentials details
# url example 1 (aws): https://s3.REGION.amazonaws.com => for S3 bucket
# url example 2 (cloudflare): https://ACCOUNT-ID.r2.cloudflarestorage.com => for r2 bucket
# url example 3 (backblaze): https://s3.REGION.backblazeb2.com => for b2 bucket
# example of credentials: CILKgshshshshshshs:pghhs-hkjskjskskksksagKSU => key:secret


clean_system () {

	if [ $clean_system_confirm = true ]; then
		sudo chmod 775 /var/lib/apt/lists/
		sudo rm -rf /var/lib/apt/lists/*
		echo -e "Y"
		echo -e "Y"
		echo -e "Y"
		sudo apt-get -y autoclean
		echo -e "Y"
		echo -e "Y"
		echo -e "Y"
		sudo apt-get -y autoremove
		echo -e "Y"
		echo -e "Y"
		echo -e "Y"
	fi
}

mount_or_unmount_storage() {

	if [ $mount_storage_confirm = true ]; then
             
	     unmount_storage_confirm=false
	     
	    # update system and then install fuse and s3f3
	    sudo apt-get -y update
	    sudo apt-get -y install fuse s3fs

	    # set credentials
	    echo $provider_credential > /etc/passwd-s3fs
	    sudo chmod 640 /etc/passwd-s3fs

	    # make mount dir & set permission
	    sudo mkdir $mount_dir
	    sudo chmod 777 $mount_dir

	    # then mount bucket with s3fs
	    sudo s3fs $bucket_name $mount_dir -o passwd_file=/etc/passwd-s3fs,nonempty,rw,allow_other,use_path_request_style,mp_umask=002,uid=$UID,gid=$UID -o url=$provider_url

	    # make permanent
	    echo $bucket_name $mount_dir 'fuse.s3fs _netdev,nonempty,rw,allow_other,use_path_request_style 0 0' >> /etc/fstab

	    # finally check content(s) of directory/bucket
	    cd $mount_dir
	    echo "Tested s3fs successfully mounted" >> $mount_dir/test-data.txt
	    sudo df -h
	    sudo df -aTh 
	    sudo ls -ltr
     
	    # show mounted hard drives partition 
	    sudo cat /proc/mounts  

	    # also, check object storage (bucket) for "test-data.txt" and check the file content to confirm
	fi

 	if [ $unmount_storage_confirm = true ]; then
            
	    mount_storage_confirm=false
     
  	    # to unmount
	    sudo umount $mount_dir
  	fi
}


main () {
	clean_system 
	mount_or_unmount_storage
}

main    
