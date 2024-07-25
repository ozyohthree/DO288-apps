# STEPS

```bash
    # Create task and pipeline
    oc create -f task.yaml
    oc create secret generic mvn-settings --from-file=settings.xml
    oc create -f pipeline.yaml
    # Add quay registry secret to pipeline serviceaccount for skopeo-copy to push image to registry
    oc create secret docker-registry registry-secret \
        --from-file=.dockerconfigjson=${XDG_RUNTIME_DIR}/containers/auth.json
    oc secrets link pipeline registry-secret
    oc create -f pipelinerun.yaml 

    # Create Trigger
    oc create -f trigger-template.yaml
    oc create -f trigger-binding.yaml
    oc create -f trigger.yaml
    oc create -f event-listener.yaml

    # Validate  
    curl -H 'Content-Type: application/json' \
        -d '{"head_commit":{"id":"pipelines-review-webhook"},"repository":{"url":"https://github.com/ozyohthree/DO288-apps","name": "apps/pipelines-review/vertx-site"}}' \
        -X POST \
        http://el-maven-java-pipeline-pipelines-review.apps.ocp4.example.com


    
```