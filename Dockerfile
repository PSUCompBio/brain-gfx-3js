#FROM amazonlinux:2
FROM public.ecr.aws/lambda/nodejs:12

ARG UNAMEX
ARG INSTANCE_TYPE
ARG NCPUS_VAR
RUN echo "'UNAMEX=${UNAMEX}'"

RUN yum update -y
RUN yum install shadow-utils -y
# RUN yum install -y git
RUN yum install -y curl
RUN yum install -y vim
#RUN yum install -y aws-cli
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
RUN . ~/.nvm/nvm.sh

# Setup home environment
RUN useradd ${UNAMEX}

WORKDIR /home/${UNAMEX}
ENV HOME /home/${UNAMEX}
RUN chown -R ${UNAMEX} /home/${UNAMEX}

RUN cd /home/${UNAMEX}
RUN pwd
ADD *.js /home/${UNAMEX}/
ADD config /home/${UNAMEX}/config
ADD README.md /home/${UNAMEX}/
ADD package.json /home/${UNAMEX}/


# #RUN /bin/bash bash_scripts/install-simple-nodejs-app.sh
# expose port 3000 for API
EXPOSE 3000

# set up a script that run whenever the docker is started.
# it will run the forever service to start the nsfcareer-api-service
#RUN ["chmod", "+x", "/home/ec2-user/bash_scripts/start-nodejs.sh"]
##ENTRYPOINT ["/bin/bash", "-c", "/home/ec2-user/bash_scripts/start-nodejs.sh"]
##CMD ["/bin/bash", "-c", "/home/ec2-user/bash_scripts/start-nodejs.sh"]
##RUN /bin/bash bash_scripts/start-nodejs.sh

# clean up and setup
#RUN /bin/bash -c "source .bashrc"
RUN chown -R ${UNAMEX} /home/${UNAMEX}