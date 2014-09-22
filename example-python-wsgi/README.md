### example-python-wsgi

This sample python wsgi app outputs "Hello World!".

It listens on either `$PORT` (the chosen port Continuum exposes via environment variable) or at port 5000.

The `runtime.txt` file instructs Continuum's python stager which version of python should be used.
