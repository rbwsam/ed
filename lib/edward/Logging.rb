module Edward
  module Logging
    def log(message)
      puts_color "[#{APP_NAME}] #{message}"
    end

    def puts_color(str)
      puts "\e[35m#{str}\e[0m"
    end
  end
end