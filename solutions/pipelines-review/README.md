# STEPS

## Create Pipeline

```bash
# Update application to version 2.0 by editing MainVertical.java output
# Validate application builds and run
mvn clean compile exec:java 

# open new terminal and validate application
curl http://localhost:8080; echo

# clean up, ctrl+c to stop application running, then delete target folder
rm -rf target

# Login to OCP 
oc login -u ...

# Login to quay via podman
podman login -u ...

# add the settings.xml to a secret for the task
oc create secret generic mvn-settings --from-file=settings.xml

# Create task 
oc create -f task.yaml

# Create pipeline
oc create -f pipeline.yaml

# Add quay registry secret for skopeo-copy to push image to registry
oc create secret docker-registry registry-secret \
    --from-file=.dockerconfigjson=${XDG_RUNTIME_DIR}/containers/auth.json

# Attach secret to pipeline service account
oc secrets link pipeline registry-secret

# Run Pipeline
oc create -f pipelinerun.yaml 

# Check logs
tkn p logs -f 

```

## Create Trigger

```bash
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
curl -H 'Content-Type: application/json'                        \
    -d '{                                                      
          "head_commit": {                                      
            "id": "pipelines-review"                            
          },                                                    
          "repository": {                                       
            "name": "apps/pipelines-review/vertx-site",         
            "url": "https://github.com/ozyohthree/DO288-apps"   
          }                                                     
        }'                                                    \
    -X POST http://el-maven-java-pipeline-pipelines-review.apps.ocp4.example.com

```
