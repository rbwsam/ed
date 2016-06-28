module Fuggle
  class System
    class << self

      def abort(message)
        Fuggle::Log.log(message)
        exit(false)
      end

    end
  end
end