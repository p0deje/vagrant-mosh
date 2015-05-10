module VagrantPlugins
  module Mosh
    class Plugin < Vagrant.plugin(2)
      name 'vagrant-mosh'
      description 'Plugin allows to use Mosh to connect to box.'

      command :mosh do
        require_relative 'command'
        Command
      end
    end
  end
end
