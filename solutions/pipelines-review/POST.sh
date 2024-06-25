 curl -H 'Content-Type: application/json' \
      -d '{"head_commit":{"id":"pipelines-review"},"repository":{"url":"https://git.ocp4.example.com/developer/DO288-apps","path": "apps/pipelines-review/vertx-site"}}' \
      -X POST \
      http://el-maven-java-pipeline-pipelines-review.apps.ocp4.example.com
