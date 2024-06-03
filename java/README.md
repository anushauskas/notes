# Java

## Switch between java versions

```sh
# Create environment variable JAVA_HOME

$env:JAVA_HOME

# Set PATH to 
$env:Path = $env:JAVA_HOME+'\bin;'+$env:Path

#Using admin console

# Switch to java 8
setx /m JAVA_HOME "C:\Program Files\Eclipse Adoptium\jdk-8.0.372.7-hotspot\

# Switch to java 17
setx /m JAVA_HOME "C:\Program Files\Java\jdk-17\
```

## VS Code Profile

Profile with arguments: 

```json
{
    "type": "java",
    "name": "MyApplicationProfile",
    "request": "launch",
    "args": "--spring.profiles.active=prod",
    "mainClass": "com.mycompany.namespace.MyApplication",
    "projectName": "mavenprojectname"
}
```