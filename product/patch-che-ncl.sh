#!/bin/bash -xe
# script apply patches/changes to upstream eclipse che so we can build it in NCL

# remove dashboard from the reactor 
# TODO: NOS-1485 re-add the dashboard
sed -i -e "s#.*<module>dashboard</module>.*##" pom.xml

# disable docs from assembly main and root pom
perl -0777 -p -i -e 's|(\ +<dependency>.*?<\/dependency>)| $1 =~ /<artifactId>che-docs<\/artifactId>/?"":$1|gse' assembly/assembly-main/pom.xml
perl -0777 -p -i -e 's|(\ +<dependencySet>.*?<\/dependencySet>)| $1 =~ /<include>org.eclipse.che.docs:che-docs<\/include>/?"":$1|gse' assembly/assembly-main/src/assembly/assembly.xml
perl -0777 -p -i -e 's|(\ +<dependency>.*?<\/dependency>)| $1 =~ /<artifactId>che-docs<\/artifactId>/?"":$1|gse' pom.xml

# remove assembly-main from the reactor
# TODO: undo this if we move this out of downstream and need it here
#sed -i -e "s#.*<module>assembly-main</module>.*##" assembly/pom.xml
# remove dep on assembly-main from the root 
#perl -0777 -p -i -e 's|(\ +<dependency>.*?<\/dependency>)| $1 =~ /<artifactId>assembly-main<\/artifactId>/?"":$1|gse' pom.xml
