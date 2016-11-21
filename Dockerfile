FROM rocker/hadleyverse:latest

# rstudio + shiny + hadleyverse R packages

MAINTAINER Sebastian Kranz "sebastian.kranz@uni-ulm.de"

#RUN su - -c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""

RUN apt-get update && \
    apt-get install -y gdebi-core

# Don't know yet how to install infrasture to manually start or stop shiny, like
# service shiny-server stop
# or
# systemctl stop shiny-server
# or
# sudo stop shiny-server
# in the container. The lines below do not yet suffice
RUN apt-get install -y systemd
RUN wget\
  https://raw.github.com/rstudio/shiny-server/master/config/upstart/shiny-server.conf\
  -O /etc/init/shiny-server.conf


RUN wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.7.815-amd64.deb
RUN gdebi -n shiny-server-1.4.7.815-amd64.deb

# Copy modified userconf.sh
COPY userconf.sh /etc/cont-init.d/conf

EXPOSE 3838

# The rocker/rstudio image uses the s6 init system
# Copy shiny-server.sh to the right location to start up the shiny server
RUN mkdir /etc/services.d/shiny-server
COPY shiny-server.sh /etc/services.d/shiny-server/run
RUN chmod 755 /etc/services.d/shiny-server/run

CMD ["/init"]
  
# docker build -t "shinyrstudio:latest" .
# docker run -d -p 3801:3838 shinyrstudio:latest