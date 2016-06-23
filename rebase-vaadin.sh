#!/bin/bash

# Must use gsed on Mac
if [[ "$OSTYPE" == "darwin"* ]]
then
        export SED=`which gsed`
else
        export SED=`which sed`
fi

if [ ! -x "$SED" ]
then
        echo "Sed not found, install gsed on Mac or sed on Linux"
        exit 1
fi


# Rename artifact
$SED -i "s#<artifactId>jsoup</artifactId>#<artifactId>jsoup-case-sensitive</artifactId>#" pom.xml

# Change package in pom.xml and java files
find . -name "*.xml" -o -name "*.java"|xargs -n 1 $SED -i "s/org.jsoup/com.vaadin.external.jsoup/g"

# Move java files to correct location
mkdir -p src/main/java/com/vaadin/external/
mv src/main/java/org/jsoup src/main/java/com/vaadin/external/
mkdir -p src/test/java/com/vaadin/external/
mv src/test/java/org/jsoup src/test/java/com/vaadin/external/
