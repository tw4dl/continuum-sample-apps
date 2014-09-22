### go-nats

Go app that performs NATS request on 'test' subject when you hit '/echo' endpoint.
It also subscribes to 'test' and echoes back 'echo' query parameter from HTTP request.
Uses 'NATS_URI' environment variable to discover a NATS server.
