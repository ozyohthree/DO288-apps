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
    oc create secret generic github-secret --from-literal=secretToken="1234567"
    # alternative: oc create -f webhook-secret.yaml
    oc create -f event-listener.yaml
    
```