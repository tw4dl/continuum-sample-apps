### example-go-var

This sample app responds to HTTP requests with "Hello, World", or with the text of a parameter you optionally pass into it following the start command via `--start-cmd=` , e.g. `apc app create app-name --start-cmd="./example-go-var TEXT"`.

The default response will be "Hello, World" or the 'TEXT' you added as a parameter to the start command. You can also see the different environment variable define by adding /env to the URI. Adding /rand will generate a random number and /echo will echo the details of the request.

