Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.provision 'shell', path: 'support/provision.sh'

  config.vm.define 'static_ip' do |machine|
    machine.vm.network :private_network, ip: '192.168.50.6'
  end

  config.vm.define 'dynamic_ip' do |machine|
    machine.vm.network :private_network, type: 'dhcp'
  end

  config.vm.define 'digitalocean', autostart: false do |machine|
    machine.vm.provider :digital_ocean do |provider, override|
      override.ssh.private_key_path = '~/.ssh/id_rsa'
      override.vm.box = 'digital_ocean'
      override.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'

      provider.token = ENV['DIGITALOCEAN_TOKEN']
      provider.image = 'ubuntu-14-04-x64'
    end
  end
end
