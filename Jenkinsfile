    node {
        
        try {
      //  notifyBuild('STARTED')
        def app
    
        stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }
    
        stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("paurangpure/chefimage")
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
            app.push("latest")
        }
    }
     stage('Deploy') {
        echo 'Deploying to Staging'
        sh "chmod 775 ./deploy.sh"
         sh './deploy.sh'
         
        
    }
  } catch (e) {
     // If there was an exception thrown, the build failed
     currentBuild.result = "FAILED"
     throw e
   } finally {
     // Success or failure, always send notifications
     notifyBuild(currentBuild.result)
   }
 }
 
 def notifyBuild(String buildStatus = 'STARTED') {
   // build status of null means successful
   buildStatus =  buildStatus ?: 'SUCCESSFUL'
 
   // Default values
   def colorName = 'RED'
   def colorCode = '#FF0000'
   def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
   def summary = "${subject} (${env.BUILD_URL})"
   def details = """<p>JOB STATUS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]': is deployed with status ${buildStatus}</p>
     <p>You can check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>"""
 
   // Override default values based on build status
  /* if (buildStatus == 'STARTED') {
     color = 'YELLOW'
     colorCode = '#FFFF00'
   } else if (buildStatus == 'SUCCESSFUL') {
     color = 'GREEN'
     colorCode = '#00FF00'
   } else {
     color = 'RED'
     colorCode = '#FF0000'
   } 
 
   // Send notifications
    slackSend (color: colorCode, message: summary)
 
     hipchatSend (color: color, notify: true, message: summary) */
 
   emailext (
       to: 'paurangpure@vdrivit.com',
       subject: subject,
       body: details,
       recipientProviders: [[$class: 'DevelopersRecipientProvider']]
     )
 }
        
     /*       stage('Email') {
         emailext ( 
       to: 'paurangpure@vdrivit.com', 
       subject: "BUILD DEPLOY STATUS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'", 
       body: """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
         <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>""",
       recipientProviders: [[$class: 'DevelopersRecipientProvider']]
     )
 } 
    }*/
