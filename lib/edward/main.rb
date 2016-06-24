module Edward
  class Main
    def initialize
      @tasks = {}
      load_tasks
      run_task
    end

    private

    def task(name, &block)
      @tasks[name] = block
    end

    def load_tasks
      self.instance_eval(File.read(tasks_file), tasks_file)
    end

    def run_task
      if ARGV.length < 2
        puts 'Usage: edward <environment> <task>'
      else
        @tasks[ARGV[1].to_sym].call
      end
    end

    def tasks_file
      "#{Dir.pwd}/edward.rb"
    end
  end
end