#!/usr/bin/env node

// Load the http module to create an http server.
var http = require('http');

// Configure our HTTP server to respond with Hello World to all requests.
var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("Hello World\n");
});

// Listen on two ports, the port defined in $PORT and $PORT + 1
server.listen(parseInt(process.env.PORT, 10));
server.listen(parseInt(process.env.PORT + 1, 10));

// Put a friendly message on the terminal
console.log("Server running at http://0.0.0.0:" + process.env.PORT + "/");
console.log("Server running at http://0.0.0.0:" + (parseInt(process.env.PORT, 10) + 1) + "/");
