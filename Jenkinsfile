node() {

    def repoURL = 'https://github.com/bford62/cucumber.git'

    stage("Prepare Workspace") {
        cleanWs()
        env.WORKSPACE_LOCAL = bat(returnStdout: true, script: 'echo %cd%').trim()
        env.BUILD_TIME = bat(returnStdout: true, script: 'powershell get-date -format "{yyyy-MM-dd-HH:mm:ss}"').trim()
        echo "Workspace set to:" + env.WORKSPACE_LOCAL
        echo "Build time:" + env.BUILD_TIME
    }
    stage('Checkout Self') {
        git branch: 'xray_video', credentialsId: '', url: repoURL
    }
    stage('Cucumber Tests') {
        withMaven(maven: 'maven35') {
            bat """
			cd ${env.WORKSPACE_LOCAL}
			mvn clean test
		"""
        }
    }
    stage('Expose report') {
        archive "**/cucumber.json"
        cucumber '**/cucumber.json'
    }
	stage('Import results to Xray') {

		def description = "[BUILD_URL|${env.BUILD_URL}]"
		def labels = '["regression","automated_regression"]'
		def environment = "DEV"
		def testExecutionFieldId = 10007
		def testEnvironmentFieldName = "customfield_10132"
		def projectKey = "Xray-Test"
		def xrayConnectorId = '3ecdab2a-9ccb-4b99-99cb-2312e9135dc5'
		def info = '''{
				"fields": {
					"project": {
					"key": "''' + projectKey + '''"
				},
				"labels":''' + labels + ''',
				"description":"''' + description + '''",
				"summary": "Automated Regression Execution @ ''' + env.BUILD_TIME + ' ' + environment + ''' " ,
				"issuetype": {
				"id": "''' + testExecutionFieldId + '''"
				},
				"''' + testEnvironmentFieldName + '''" : [
				"''' + environment + '''"
				]
				}
				}'''

			echo info

			step([$class: 'XrayImportBuilder', endpointName: '/cucumber/multipart', importFilePath: 'target/cucumber.json', importInfo: info, inputInfoSwitcher: 'fileContent', serverInstance: xrayConnectorId])
		}
}