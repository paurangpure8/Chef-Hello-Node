docker rmi -f paurangpure/chefimage:master || echo "master branch moving on"
docker tag "paurangpure/chefimage:${BUILD_TAG}"paurangpure/chefimage:master
docker push paurangpure/chefimage:master
