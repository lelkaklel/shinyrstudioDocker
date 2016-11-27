The idea of this Docker container is that you can have one or several shiny apps and at the same time can run RStudio in the container for debugging and development purposes. The idea would be to have one container for each shiny application. Updates of packages or unix shell tools in one container would then not break other shiny apps. 

Having RStudio access to each shiny app container is just for convenience. You can then log-in to the RStudio webinterface with the specified username and then modify stuff in the running container, e.g. install new R packages for testing purposes. To log-in into the rstudio webinterface for this container you just need to type the adress of your webserver using the port to which you have mapped rstudio (e.g. 8701 in the example below).

To run the container adapt the following command:

```
docker run -entrypoint="/usr/bin/with-contenv bash" --name shinyrstudio -d -p 8701:8787 -p 3801:3838 \
  -e ROOT=TRUE -e USER=<YourUsername> -e PASSWORD=<YourSecurePassword> \
  -v ~/docker/shiny/app/:/srv/shiny-server/ \
  -v ~/docker/shinyrstudio/admin_home:/home/admin/work \
  -v /srv/shinylog/:/var/log/ \
  skranz/shinyrstudio:latest  
```

### port remapping
The -p options allows to remap ports:

We use here:
```
-p 8701:8787 -p 3801:3838
```
We remap the RStudio port from the default 8787 to 8701 and the shiny-server port from the default 3838 to 3801. If you have several rstudio shiny server container, you want to have different ports for each container. You can customize the 8701 and 3801 to your desired ports, but most keep the 8787 and 3838 in the code.

### RStudio username and passwort
```
  -e ROOT=TRUE -e USER=<YourUsername> -e PASSWORD=<YourSecurePassword>
```

You must replace `<YourUsername>` by a user name (removing the < >)with which you can log-in to RStudio running in the container via a webbrowser. Similarly, replace `<YourSecurePassword>`. 

Please pick a secure password (and try to avoid  a standard username like admin or rstudio). Brute-force attacks on webservers that try out common passwords and usernames are VERY VERY common. 

True most attacks probably target ssh login on your server on port 22.

(If you have not disabled PasswordAuthentification on your server, try running `sudo lastb` when you are logged in the shell of your webserver. On a rented webserver of mine, I saw each minute more than 10 attempts to hack the root password. For some basic security measures see e.g. the tutorial here: [https://www.linux.com/learn/how-make-your-linux-server-more-secure](https://www.linux.com/learn/how-make-your-linux-server-more-secure)
)

Yet attacks on the rstudio server port, may well happen. Picking a simple common password thus may result in your container beeing quickly hacked. So choose a secure, long password!




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

