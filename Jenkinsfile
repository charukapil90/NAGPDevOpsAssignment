pipeline
{
  agent any
  tools
  {
   maven 'Maven'
  }
  stages
  {
    stage('checkout')
    {
      steps
	  {
      checkout scm
      }
    }
    stage('Build')
    {
      steps
	  {
      bat "mvn install"
      }
    }
    stage('Unit Testing')
    {
      steps
	  {
      bat "mvn test"
      }
    }
    stage('Sonar Analysis')
    {
      steps
      {
        withSonarQubeEnv("Test_Sonar")
          {
 	  bat "mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar"
          }
      }
     }
    stage('Upload to Artifactory')
    {
      steps
      {
	withCredentials([usernamePassword(credentialsId:'NewOne', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
		
        rtMavenDeployer (
			id: 'deployerNew',
			serverId: 'charu@artifactory',
			releaseRepo: 'nagpAssignment',
			snapshotRepo: 'nagpAssignment',          
          )
        rtMavenRun (
			pom: 'pom.xml',
			goals: 'clean install',
			deployerId: 'deployerNew',
          )
        rtPublishBuildInfo (
			serverId: 'charu@artifactory',
          )
	}
      }
     } 
    stage('Build Image')
    {
	steps
	{
		bat "docker build -t mysecondimage:${BUILD_NUMBER} ."
    	}
  }	  
    stage('Docker Deployment')
    {
	steps
	{
		bat "docker run --name mySecondContainer -d -p 9021:8080 mysecondimage:${BUILD_NUMBER}"
    	}
  }	  
   }
   post{
	success
	{
        bat "echo success"
    }
    }
    }
