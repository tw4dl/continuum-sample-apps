### continuum-stager-api

This is a sample sinatra stager using our Continuum Stager API.

## Loading the Stager

```console
apc stager create myrubystager --start-command="./stager.rb" --staging=/apcera::ruby --pipeline
```

## Deploying with the Stager

To deploy an application with the new sinatra stager and staging pipeline, you can use the
`apc app create` command along with specifying the use of the `myrubystager` staging
pipeline. This can be tested with the 'demo-ruby-sinatra' application in sample-apps.

```console
apc app create rubyappname --staging=myrubystager --start
```
