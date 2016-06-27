module Edward
  class System
    class << self

      def abort(message)
        Edward::Log.log(message)
        exit(false)
      end

    end
  end
end