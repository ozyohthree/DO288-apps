tkn p start maven-java-pipeline \
  -w name=shared,volumeClaimTemplateFile=volume-template.yaml \
  -w name=maven_config,secret=mvn-settings \
  -p GIT_REPO="https://git.ocp4.example.com/developer/DO288-apps" \
  -p GIT_REVISION="master" \
  -p MVN_APP_PATH="apps/pipelines-review/vertx-site" \
  -p DEPLOY_ARTIFACT_NAME="target/vertx-site-1.0.0-SNAPSHOT-fat.jar" \
  -p DEPLOY_APP_NAME="vertx-site" \
  --use-param-defaults
