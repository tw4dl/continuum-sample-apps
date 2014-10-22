# Example Sinatra Cloudant

A modified BlueMix app to highlight cloudant services within Continuum. This app
requires the stager included in the 'stager' directory. The stager will run
through all cloudant integration tests before validating an app deploy.

## Add the Cloudant Provider

The app expects a cloudant provider at /prod::cloudant. To set this up run the following:

```console
$ apc provider register /prod::cloudant -u http://<cloudant-user>:<cloudant-password>@<cloudant-user>.cloudant.com -t cloudant
```

## Loading the App

```console
$ apc app create --start
```
