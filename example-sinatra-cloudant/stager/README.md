# Sinatra Stager

This is a sample sinatra stager using our Continuum Stager API.

## Loading the Stager

```console
$ apc stager create /example/stagers::sinatra --start-command="./stager.rb" --staging=/apcera::ruby --pipeline -ae
```

## Deploying with the Stager

To deploy an application with the new sinatra stager and staging pipeline, you can use the
`apc app create` command along with specifying to use the `sinatra` staging
pipeline. This can be tested with the 'example-sinatra-cloudant' application in sample-apps.
This application has a manifest that will setup all needed services and settings.

```console
$ cd <path/to/example-sinatra-cloudant>
$ apc app create --start
```
