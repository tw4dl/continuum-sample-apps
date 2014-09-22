### example-ruby-manifest

This sample app is a simple ruby app that demonstrates the use of an app manifest (by default, `continuum.conf`) in order to create an app with easily reproducible settings.

Deployment is simple:

```console
cd example-ruby-manifest
apc app create
```

The custom configuration `services.conf` is a separate manifest file that demonstrates the use of manifest files in creating and binding to services at application creation time.
