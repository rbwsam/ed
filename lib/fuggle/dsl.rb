require 'tempfile'

module Fuggle
  class Dsl
    def initialize(tasks, environments)
      @hosts = []
      @ssh_opts = ''

      @tasks = {}
      @environments = {}
      @templates = {}

      [environments, tasks].each { |thing| instance_eval(thing) }

      load_environment(ARGV[0])
      execute_task(ARGV[1])
    end

    def task(name, &block)
      @tasks[name] = block
    end

    def environment(name, &block)
      @environments[name] = block
    end

    def template(name, &block)
      @templates[name] = block
    end

    def remote_template(hosts, name, remote_path, sudo = false)
      tmp_file = Tempfile.new('remote_template')
      File.write(tmp_file.path, compile_template(name))
      if sudo
        remote_tmp_file_path = "/tmp/#{File.basename(tmp_file.path)}"
        sync(hosts, tmp_file.path, remote_tmp_file_path)
        remote(hosts, "sudo mv #{remote_tmp_file_path} #{remote_path}")
      else
        sync(hosts, tmp_file.path, remote_path)
      end
      tmp_file.unlink
    end

    def compile_template(name)
      @templates[name].call
    end

    def local(cmd)
      run(cmd, 'Local command failed')
    end

    def remote(hosts, cmd)
      hosts.map { |host|
        run("ssh #{@ssh_opts} #{host} \"#{cmd}\"", 'Remote command failed')
      }
    end

    def sync(hosts, local_path, remote_path, opts = '')
      hosts.each do |host|
        cmd = "rsync #{opts} -e \"ssh #{@ssh_opts}\" #{local_path} #{host}:#{remote_path}"
        run(cmd, 'Sync failed')
      end
    end

    def log(message)
      puts "\e[33m#{message}\e[0m"
    end

    def exists?(host, path)
      begin
        run("ssh #{@ssh_opts} #{host} \"test -e #{path}\"")
        true
      rescue Fuggle::Exception::Abort
        false
      end
    end

    private

    def load_environment(name)
      name = name.to_sym
      if @environments[name].nil?
        Fuggle::System.abort "Unknown environment '#{name}'"
      else
        @environments[name].call
      end
    end

    def execute_task(name)
      name = name.to_sym
      if @tasks[name].nil?
        Fuggle::System.abort "Unknown task '#{name}'"
      else
        @tasks[name].call
      end
    end

    def run(cmd, failure_message = 'Command failed')
      res = `#{cmd}`
      if $? != 0 # Check command exit status
        raise Fuggle::Exception::Abort.new("#{failure_message} '#{cmd}'")
      end
      res
    end

  end
end
