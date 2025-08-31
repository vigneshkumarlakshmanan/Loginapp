# Use Tomcat as base image
FROM tomcat:9.0-jdk17-openjdk

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR into Tomcat webapps folder
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
