 curl -H 'Content-Type: application/json' \
      -d '{"head_commit":{"id":"pipelines-review-webhook"},"repository":{"url":"https://github.com/ozyohthree/DO288-apps","path": "apps/pipelines-review/vertx-site"}}' \
      -X POST \
      http://el-maven-java-pipeline-pipelines-review.apps.ocp4.example.com
