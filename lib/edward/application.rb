module Edward
  class Application
    def initialize
      check_args
      check_files

      Dsl.new(File.read(tasks_file), File.read(environments_file))
    end

    private

    def check_args
      if ARGV.length != 2
        Edward::System.abort "Usage: #{APP_NAME} <environment> <task>"
      end
    end

    def check_files
      fail = false
      unless File.exist?(tasks_file)
        Edward::Log.log "Missing tasks file: #{tasks_file}"
        fail = true
      end
      unless File.exist?(environments_file)
        Edward::Log.log "Missing environments file: #{environments_file}"
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