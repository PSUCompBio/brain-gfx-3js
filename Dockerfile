FROM amazonlinux:2
# FROM public.ecr.aws/lambda/nodejs:12

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
RUN pwd
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

# set up nodejs
# #RUN /bin/bash bash_scripts/install-simple-nodejs-app.sh
# expose port 3000 for API
EXPOSE 3000
RUN mkdir /var/www
RUN mkdir /var/www/brain-gfx-3js
ADD *.js /var/www/brain-gfx-3js/
ADD config /var/www/brain-gfx-3js/config
ADD README.md /var/www/brain-gfx-3js/
ADD package.json /var/www/brain-gfx-3js/
RUN cd /var/www/brain-gfx-3js/
RUN curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
RUN curl -sL https://rpm.nodesource.com/setup_12.x |  bash -
RUN yum -y install yarn
RUN yum -y install nodejs
RUN npm install

# set up a script that run whenever the docker is started.
# it will run the forever service to start the nsfcareer-api-service
#RUN ["chmod", "+x", "/home/ec2-user/bash_scripts/start-nodejs.sh"]
##ENTRYPOINT ["/bin/bash", "-c", "/home/ec2-user/bash_scripts/start-nodejs.sh"]
##CMD ["/bin/bash", "-c", "/home/ec2-user/bash_scripts/start-nodejs.sh"]
##RUN /bin/bash bash_scripts/start-nodejs.sh

# clean up and setup
#RUN /bin/bash -c "source .bashrc"
RUN chown -R ${UNAMEX} /home/${UNAMEX}
