curl -H 'Content-Type: application/json'                        \
     -d '{                                                      \
          "head_commit": {                                      \
            "id": "pipelines-review"                            \
          },                                                    \
          "repository": {                                       \
            "name": "apps/pipelines-review/vertx-site",         \
            "url": "https://github.com/ozyohthree/DO288-apps"   \
          }                                                     \
          }'                                                    \
     -X POST http://el-maven-java-pipeline-pipelines-review.apps.ocp4.example.com
