## example-heroku-postgres-sg

This is a sample postgres service gateway for heroku. It demonstrates Continuum's ability to take a staged application and promote it to act as a service gateway for brokering connections between services and consumers.

## Deployment

1) Deploy the example-heroku-postgres-sg
```console
cd EXAMPLE_SG_APP_DIR
apc app create heroku-postgres --disable-routes
```

2) Promote the app to a service gateway
```console
apc gateway promote heroku-postgres --type postgresql
```

3) Create a service
``` console
apc service create heroku_mytest -- -url postgres://user:pass@url:port/db
```
