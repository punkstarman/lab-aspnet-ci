node {
	stage "Checkout"
	checkout scm

	dockertool = tool name: 'Default', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'

	withEnv(["PATH+DOCKER=${dockertool}"]) {
		stage "Build project"
		def aspnet = "microsoft/aspnet:1.0.0-rc1-update1-coreclr"
		def dnxframework = "dnxcore50"
		def docker_run = "docker run --rm -v aspnetci_jenkins_data:/var/jenkins_home -v aspnetci_dnx:/root/.dnx -w ${pwd()} ${aspnet}"
		sh "${docker_run} dnu restore"
		sh "${docker_run} dnu publish --framework ${dnxframework}"
		sh "${docker_run} chown -R 1000:1000 ."

		stage "Build docker image"
		def app = "aspnet-hello"
		def tag = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
		echo "Tagging docker image ${app}:${tag}"
		sh "docker build -t ${app}:${tag} ."
	}
}
