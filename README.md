<<<<<<< HEAD
The idea of this Docker container is that you can have one or several shiny apps and at the same time can run RStudio in the container for debugging and development purposes. The idea would be to have one container for each shiny application. Updates of packages or unix shell tools in one container would then not break other shiny apps. Having RStudio access to each shiny app container is just for convenience.

To run the container adapt the following command:
=======
The idea of this Docker container is that you can have one or several shiny apps and at the same time can run RStudio in the container for debugging and development purposes. To run the container adapt the following command:
>>>>>>> 234d17fb85c75aed894436ffafa99c51eae235b7

```
docker run -entrypoint="/usr/bin/with-contenv bash" --name shinyrstudio -d -p 8701:8787 -p 3801:3838 \
  -e ROOT=TRUE -e USER=admin -e PASSWORD=test \
  -v ~/docker/shiny/app/:/srv/shiny-server/ \
  -v ~/docker/shinyrstudio/admin_home:/home/admin/work \
  -v /srv/shinylog/:/var/log/ \
  shinyrstudio:latest  
```

### port remapping
The -p options allows to remap ports:

We use here:
```
-p 8701:8787 -p 3801:3838
```

<<<<<<< HEAD
We remap the RStudio port from the default 8787 to 8701 and the shiny-server port from the default 3838 to 3801. 
Port remapping is neccessary if on your server you run several containers with rstudio and shiny server. You can customize the 8701 and 3801 to the desired ports for this container, but you most keep the 8787 and 3838 in call.
=======
We remap the RStudio port from the default 8787 to 8701 and the shiny-server port from the default 3838 to 3801. If you have several rstudio shiny server container, you want to have different ports for each container. You can customize the 8701 and 3801 to your desired ports, but most keep the 8787 and 3838 in the code.
>>>>>>> 234d17fb85c75aed894436ffafa99c51eae235b7

### RStudio username and passwort
```
  -e ROOT=TRUE -e USER=admin -e PASSWORD=test \
```
<<<<<<< HEAD
The default user name for using RStudio inside the container is `admin`. You should not change that username, but you should change the password to something else than `test`. 

With the user name `admin` you can then log-in to the RStudio webinterface and then modify stuff in the running container, e.g. install new R packages for testing purposes.

To log-in into the rstudio webinterface for this container you just need to type the adress of your webserver using the port to which you have mapped rstudio, e.g.
=======
By default your RStudio user inside the container has the name "admin". You should not change the username, but should change the password to something else than `test`. 

With the user name admin you can then log in using the RStudio webinterface and then modify stuff in the running container, e.g. install new packages for testing purposes. To login into the rstudio running in the container you just need to type the adress of your webserver using the port to which you have mapped rstudio, e.g.
>>>>>>> 234d17fb85c75aed894436ffafa99c51eae235b7

```
www.myserver.com:8701
```

<<<<<<< HEAD
You can thus have different RStudios on the server for different containers, that can be accessed by different ports.

=======
>>>>>>> 234d17fb85c75aed894436ffafa99c51eae235b7

### mounted directories

The lines:
```
  -v ~/docker/shiny/app/:/srv/shiny-server/ \
  -v ~/docker/shinyrstudio/admin_home:/home/admin/work \
  -v /srv/shinylog/:/var/log/ \
```
mount different directories on your server (left of each :) to a directory in the docker container (right of each :). You can adapt the left directories but must keep the right directories as given.

The first line
```
  -v ~/docker/shiny/app/:/srv/shiny-server/ \
```
specifies the shiny apps directory on your server. The second line
```
  -v ~/docker/shinyrstudio/admin_home:/home/admin/work \
```
specifes the directory on your server that corresponds to the /home/admin directory in the container. That is the default directory, when you login as admin in RStudio.

