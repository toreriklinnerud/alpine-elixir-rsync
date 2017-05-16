# alpine-elixir-rsync
Zero config development Exlir development environment based on the lightweight Alpine Linux distribution to keep the image size managable. 
Your github username is used to find your public SSH key, after which you can log straight in without any configuration required. The idea is that you can easily edit the project on your laptop whilst compiling and running your code on a powerful server.

If running the docker image on a server replace `localhost` with the corresponding hostname

### To launch the Elixir environment

This assumes that you've first added your public key to your GitHub profile (common).
```bash
  docker run -p 22:22 alpine-elixir-rsync <your_github_username>
```

### To connect over ssh
```bash
  ssh default@localhost
```

### To continously sync an existing Elixir project from OS X to the Elixir enviroment
```bash
   brew install fswatch
   cd ~/<your>/<local_app_folder>
   alias run_rsync='rsync -azP --exclude ".*/" --exclude ".*" --exclude "tmp/" . default@localhost:/opt/app'
   run_rsync; fswatch -o . | while read f; do run_rsync; done
 ```

### Run your Elixir code
```bash
   ssh default@localhost
   cd <your_app>
   iex -S mix # etc...
```
