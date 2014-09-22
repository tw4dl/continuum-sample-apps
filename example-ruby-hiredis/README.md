### example-ruby-hiredis

This sample Ruby app consumes a Redis service exposed via the `REDIS_URI` environment variable, exposing `/set` and `/get` endpoints to record and retrieve values.

To use this application with a redis service in Continuum:

1. Create the app:
```console
cd example-ruby-hiredis
apc app create hiredis
```

2. Create the redis service:
```console
apc service create redisdb --type redis
```

3. Bind the application to the new service:
```console
apc service bind redisdb --app hiredis
```

4. Start the app:
```console
apc app start hiredis
```

5. Set and get values using curl:

*Setting value to 1:*
```console
curl -X POST http://hiredis.<your-domain>/set/value/1 -d ''
```

*Getting the value of `value`:*
```console
curl http://hiredis.<your-domain>/get/value
```


