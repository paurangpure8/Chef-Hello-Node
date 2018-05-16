docker stop chefContainer1
sleep 5
docker rm chefContainer1
sleep 5
docker rmi $(docker images |grep 'paurangpure/chefimage')
sleep 5
sudo chef-client
