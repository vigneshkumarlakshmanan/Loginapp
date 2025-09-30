# Use the latest official Tomcat image (includes JDK)
FROM tomcat:latest

# Remove default apps (like examples, docs, ROOT)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR into Tomcat webapps folder as ROOT
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Set entrypoint to run Tomcat
ENTRYPOINT ["catalina.sh", "run"]
