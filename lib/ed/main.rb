module Ed
  class Main
    def initialize
      @tasks = {}
      load_tasks
    end

    private

    def task(name, &block)
      @tasks[name] = block
    end

    def load_tasks
      self.instance_eval(File.read(tasks_file), tasks_file)
      puts @tasks
    end

    def tasks_file
      "#{Dir.pwd}/ed.rb"
    end
  end
end