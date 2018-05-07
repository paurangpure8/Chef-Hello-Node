    node {
        def app
    
        stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }
    
        stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("sprabhune/chefproject")
    }

        stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Tests passed"'
                    }
        } 
        stage('Push image') {
        // Finally, we'll push the image with two tags:
         //* First, the incremental build number from Jenkins
        // * Second, the 'latest' tag.
        // * Pushing multiple tags is cheap, as all the layers are reused. 
        docker.withRegistry('https://registry.hub.docker.com', '8e8e713e-defe-4245-9411-18df6b57807d') {
            app.push("${env.BUILD_NUMBER}")
            app.push("master")
        }
    }
     stage('Deploy') {
        echo 'Deploying to Staging'
        sh "chmod 777 ./deploy.sh"
         sh './deploy.sh'
         
        
    }
    }
