module VagrantPlugins
  module Mosh
    class Command < Vagrant.plugin(2, :command)
      def self.synopsis
        'connects to machine via Mosh'
      end

      def execute
        opts = OptionParser.new do |o|
          o.banner = 'Usage: vagrant mosh [vm-name]'
          o.separator ''
        end
        argv = parse_options(opts)
        return unless argv

        with_target_vms(argv, single_target: true) do |vm|
          ssh_info = vm.ssh_info
          switch_to_remote_ip(ssh_info, vm) if localhost?(ssh_info[:host])
          mosh_command = ['mosh', *mosh_arguments(ssh_info)].join(' ')
          Vagrant::Util::SafeExec.exec(mosh_command)
        end
      end

      private

      def localhost?(host)
        %w[localhost 127.0.0.1].include?(host)
      end

      def switch_to_remote_ip(ssh_info, vm)
        ssh_info.delete(:port)
        if ip = find_remote_ip(vm)
          ssh_info[:host] = ip
        else
          raise "Cannot find remote box IP address. Make sure you're not using NAT."
        end
      end

      def find_remote_ip(vm)
        adapter_numbers = vm.provider.driver.read_network_interfaces.keys
        adapter_numbers.map do |adapter_number|
          begin
            vm.provider.driver.read_guest_ip(adapter_number)
          rescue Vagrant::Errors::VirtualBoxGuestPropertyNotFound
            nil
          end
        end.compact.first
      end

      def mosh_arguments(ssh_info)
        [
          "--ssh", "'#{ssh_command(ssh_info)}'",
          "#{ssh_info[:username]}@#{ssh_info[:host]}"
        ]
      end

      # This method pretty much duplicates `Vagrant::Util::SSH.exec`.
      #
      # It would be great to be able to get this logic from Vagrant itself
      # but it requires some core changes.
      def ssh_command(ssh_info)
        command_options = %W[
          -o Compression=yes
          -o DSAAuthentication=yes
          -o LogLevel=#{ssh_info[:log_level] || 'FATAL'}
          -o StrictHostKeyChecking=no
          -o UserKnownHostsFile=/dev/null
        ]

        if ssh_info[:forward_x11]
          command_options += %w[
            -o ForwardX11=yes
            -o ForwardX11Trusted=yes
          ]
        end

        if ssh_info[:forward_agent]
          command_options += %w[-o ForwardAgent=yes]
        end

        ssh_info[:private_key_path].each do |path|
          command_options += ['-i', path]
        end

        if ssh_info[:port]
          command_options += ['-p', ssh_info[:port]]
        end

        "ssh #{command_options.join(' ')}"
      end
    end
  end
end
