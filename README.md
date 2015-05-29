### Continuum Sample Apps

These sample apps show how to use a variety of different languages and frameworks with Continuum, demonstrating its diversity of workloads and developer-friendly features.

- To see more about creating your own stagers, check out [stager-jekyll](https://github.com/apcera/continuum-sample-apps/tree/master/stager-jekyll) and [stager-td-agent](https://github.com/apcera/continuum-sample-apps/tree/master/stager-td-agent).

- To see more about creating applications with manifest files, check out [example-ruby-manifest](https://github.com/apcera/continuum-sample-apps/tree/master/example-ruby-manifest).

- To see more about promoting an application to act as a service gateway, see [example-redis-sg](https://github.com/apcera/continuum-sample-apps/tree/master/example-redis-sg).

- To see more about consuming multiple services with an application, see [demo-node-todo](https://github.com/apcera/continuum-sample-apps/tree/master/demo-node-todo).

Each sample is licensed under the MIT license unless otherwise specified.

### Using Vagrant to launch Continuum trial image

The easiest way to try Continuum locally on your machine is to use Vagrant. You can use the Vagrantfile in this repo to launch Apcera Continuum trial VirtualBox image. Make sure your VitualBox and Vagrant tools are already [setup](http://docs.vagrantup.com/v2/getting-started/index.html). 
To bring up the box, use "vagrant up --provider=virtualbox". You will be prompted for the bridge interface. Typically picking "1" is safe. Then access the machine with "vagrant ssh"
. Inside the machine, first note the externally reachable interface on eth1 by doing "ifconfig". Then do "sudo continuum-setup". Instead of accepting the eth0's IP address, use the eth1's address. 



