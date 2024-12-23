FROM jenkins/jenkins:lts

# Install OpenJDK 17
USER root
RUN apt-get update && apt-get install -y openjdk-17-jre

# Install default Jenkins plugins including CasC
RUN jenkins-plugin-cli --plugins     configuration-as-code     git     workflow-aggregator     credentials-binding     matrix-auth     docker-workflow     ssh-agent     text-finder     htmlpublisher

# Copy CasC configuration to the Jenkins configuration directory
COPY casc-config/jenkins.yaml /var/jenkins_home/casc_configs/jenkins.yaml

# Set the CasC configuration path
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs/jenkins.yaml

# Expose Jenkins port
EXPOSE 8082