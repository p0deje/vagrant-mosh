vagrant-mosh [![Gem Version](https://badge.fury.io/rb/vagrant-mosh.svg)](http://badge.fury.io/rb/vagrant-mosh)
============

Vagrant plugin to connect to box using [Mosh](https://mosh.mit.edu/).

Installation
------------

```bash
$ vagrant plugin install vagrant-mosh
```

Usage
-----

Just use it as you would normally use `ssh` command:

```bash
$ vagrant mosh
```

Notes
-----

1. You have to install Mosh both on host and box by yourself.
2. Plugin has been tested to work with VirtualBox, AWS and DigitalOcean.
3. If you are using VirtualBox, it's required to use private/public network (that is because we need to have remote IP address from the box).

Testing
-------

Unfortunately, it's not that easy to write automated tests for it. The test should probably just run `vagrant mosh`, execute command in box and assert the result, but the way Mosh works doesn't allow to just execute the process.

Discussion on `#mosh`:

```
p0deje: can anybody help me run mosh programmatically?
p0deje: I want to run mosh from Ruby script, execute command and return
p0deje: the script works fine for SSH, but not for Mosh
p0deje: script itself is at https://gist.github.com/p0deje/c5dbfa0d137e8c11d3f5
chris2: i guess expect doesnt like mosh's efficient redrawing
...
chris2: perhaps you can work around by running mosh in tmux and exporting the output of tmux...
chris2: anyway, you need something that understands ANSI sequences
```

To test it manually, there is a Vagrantfile which helps you do that:

```bash
# start all boxes
$ bundle exec rake box:add
$ bundle exec vagrant up

$ bundle exec vagrant mosh static_ip   # test VirtualBox static IP networking
$ bundle exec vagrant mosh dynamic_ip  # test VirtualBox DHCP networking

# remove all boxes
$ bundle exec vagrant destroy
$ bundle exec rake box:remove
```

Also, it's possible to test remote providers (if you have [DigitalOcean](https://www.digitalocean.com/) account):

```bash
$ export DIGITALOCEAN_TOKEN="your_token"
$ bundle exec vagrant up digitalocean
$ bundle exec vagrant mosh digitalocean
$ bundle exec vagrant destroy digitalocean
```

TODO
----

1. Try to forward UDP ports rather finding remote IP address of the box.
2. Add tests.
3. Refactor to work as action.

Contributing
------------

* Fork the project.
* Make your feature addition or bug fix.
* ~~Add tests for it. This is important so I don't break it in a future version unintentionally.~~ (no automated tests exist at the moment)
* Commit, do not mess with Rakefile, version, or history. If you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull.
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2015 Alex Rodionov. See LICENSE.md for details.
