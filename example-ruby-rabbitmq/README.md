### example-ruby-rack-rabbitmq

Simple Sinatra app exposing endpoints for publishing and popping
a RabbitMQ queue.

The RabbitMQ service is exposed to the app via the `AMQP_URI` environment variable.
