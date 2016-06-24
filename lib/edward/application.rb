module Edward
  class Application
    include Edward::Logging

    def initialize
      check_args
      check_files
      run
    end

    private

    def run
      dsl = Dsl.new(File.read(tasks_file), File.read(environments_file))
      dsl.run
    end

    def check_args
      if ARGV.length != 2
        puts_color "Usage: #{APP_NAME} <environment> <task>"
      end
    end

    def check_files
      unless File.exist?(tasks_file)
        puts_color "Missing required file: #{tasks_file}"
        fail = true
      end
      unless File.exist?(environments_file)
        puts_color "Missing required file: #{environments_file}"
        fail = true
      end
      exit(false) if fail
    end

    def tasks_file
      "#{Dir.pwd}/Edwardfile"
    end

    def environments_file
      "#{Dir.pwd}/Edwardfile.env"
    end

  end
end