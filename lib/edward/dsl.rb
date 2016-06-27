module Edward
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

    def render(name)
      @templates[name].call
    end

    def local(cmd)
      run(cmd, 'Local command failed')
    end

    def remote(cmd)
      @hosts.each do |host|
        run("ssh #{@ssh_opts} #{host} \"#{cmd}\"", 'Remote command failed')
      end
    end

    def sync(local_path, remote_path, opts = '')
      @hosts.each do |host|
        cmd = "rsync #{opts} -e \"ssh #{@ssh_opts}\" #{local_path} #{host}:#{remote_path}"
        run(cmd, 'Sync failed')
      end
    end

    def log(message)
      puts "\e[33m#{message}\e[0m"
    end

    private

    def load_environment(name)
      name = name.to_sym
      if @environments[name].nil?
        Edward::System.abort "Unknown environment '#{name}'"
      else
        @environments[name].call
      end
    end

    def execute_task(name)
      name = name.to_sym
      if @tasks[name].nil?
        Edward::System.abort "Unknown task '#{name}'"
      else
        @tasks[name].call
      end
    end

    def run(cmd, failure_message = 'Command failed')
      system cmd
      if $? != 0 # Check command exit status
        Edward::System.abort "#{failure_message} '#{cmd}'"
      end
    end

  end
end
