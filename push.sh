docker rmi -f sprabhune/chefproject:master || echo "master branch moving on"
docker tag "sprabhune/chefproject:${BUILD_TAG}"sprabhune/chefproject:master
docker push sprabhune/chefproject:master
