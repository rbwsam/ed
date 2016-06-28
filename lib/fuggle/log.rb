module Fuggle
  class Log
    class << self

      def log(message)
        puts colorize("[#{APP_NAME}] #{message}")
      end

      private

      def colorize(str)
        "\e[31m#{str}\e[0m"
      end
    end
  end
end