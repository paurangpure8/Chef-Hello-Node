docker stop chefContainer1
docker rm chefContainer1
docker rmi $(docker images |grep 'paurangpure/chefimage')
sudo chef-client
