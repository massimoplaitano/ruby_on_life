# Ruby on Life project

It's a testbed of various tecnologies.

First of all Ruby on Rails 7 and new assets pipeline without Webpack.

A natural conseguence is the use of Tailwind CSS with powerful JIT compiler that builds very small CSS assets with only used classes.

I only scratched the surface of Turbo and Hotwire, but either are on TODO.

Only a bit of Rspec, but a deeper testing coverage is on schedule.

And why not simplify developers life? This project is configured for develop on Devcontainer or GitPod with very fast warm up.


# Demo

There is a [demo version](https://ruby-on-life.herokuapp.com/).

You can find some testing users on [db/seeds.rb](db/seeds.rb), or you can sign up with a valid email.


# Command line version

Install Ruby 3 or later. There is no dependencies, so no need to use bundler.
Execute the cli.rb script passing a file path: 
```bash
./cli.rb game_grid.txt
```

# Dev warm up with devcontainer

Clone this Git repository on your system.

Open project directory with Visual Studio Code and follow the instructions to install "Remote - Containers" extension and execute command (CTRL+SHIFT+P) "Remote-Containers: Reopen in Container".


# Rails server

To start the server and background services to compile assets on the fly, open a terminal (Bash for examplel) and execute:
```bash
bin/dev
```


# Development on GitPod

Create an account on https://gitpod.io and prefix `gitpod.io/#` on this repository url:
https://gitpod.io/#https://github.com/massimoplaitano/ruby_on_life

Wait building image and dependency installation. Rails development server starts automatically.


# TODO

- [ ] better error handling
- [ ] more method comments with usage samples
- [ ] add permissions or roles
- [ ] add user administration
- [ ] add game search
- [ ] new game from drawable grid (what JS framework?)
- [ ] better test coverage
- [ ] analyze other storage formats for grid game instead of JSON bidimensional array: string, flatten array, bytea
- [ ] better use of Turbo for small page changes
- [ ] add 2FA authentication

