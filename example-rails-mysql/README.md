# Example Rails MySQL

This is a simple app to highlight mysql services within Continuum. This app
requires the stager included in the 'stager' directory. The stager will run
through all rspecs tests before validating an app deploy. Follow the instruction 
in the REAMDE.md file under 'stager' directory, and then do the following.

## Loading the App

```console
$ apc app create --start
```

## Setting up the DB for Production

```console
$ apc app run example-rails-mysql -c "bundle exec rake db:migrate"
```
