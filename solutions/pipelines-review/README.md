# STEPS

## create pipeline

```bash
# Validate application builds and run
mvn clean compile exec:java 
# Login to OCP using alias
oclogin
# Login to quay via podman using alias
podmanlogin
# Create task and pipeline
oc create -f task.yaml
oc create secret generic mvn-settings --from-file=settings.xml
oc create -f pipeline.yaml
# Add quay registry secret to pipeline serviceaccount for skopeo-copy to push image to registry
oc create secret docker-registry registry-secret \
    --from-file=.dockerconfigjson=${XDG_RUNTIME_DIR}/containers/auth.json
oc secrets link pipeline registry-secret
oc create -f pipelinerun.yaml 
tkn p logs -f 

```

## [Create Trigger](https://tekton.dev/vault/triggers-v0.26.x-lts/)

```bash

# Create Trigger
# A TriggerTemplate is a resource that exposes parameters that can be 
# used in any of the resources in the resources template eg PipelineRun 
oc create -f trigger-template.yaml

# TriggerBindings specifies the fields from the event payload to be used
# as parameters in the TriggerTemplate
oc create -f trigger-binding.yaml

# A Trigger specifies a TriggerTemplate, a TriggerBinding, and optionally, 
# an Interceptor.
oc create -f trigger.yaml

# An EventListener listens for events at a specified port on your cluster. 
# Also Specifies one or more Triggers.
oc create -f event-listener.yaml

# Expose the Event Listener Service
oc expose svc el-maven-java-pipeline



# Validate  
curl -H 'Content-Type: application/json'                          \
     -d '{                                                        
            "head_commit": {                                      
              "id": "pipelines-review-soln"                       
            },                                                    
            "repository": {                                       
              "name": "apps/pipelines-review/vertx-site",         
              "url": "https://github.com/ozyohthree/DO288-apps"   
            }                                                     
          }'                                                      \
     -X POST http://el-maven-java-pipeline-pipelines-review.apps.ocp4.example.com
    
```