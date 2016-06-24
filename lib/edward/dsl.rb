module Edward
	class Dsl
    include Edward::Logging
		 
		def initialize(tasks, environments)
			@tasks = @environments = {}

			[tasks, environments].each { |thing| instance_eval(thing) }
    end

    def run
      @environments[ARGV[0].to_sym].call
      @tasks[ARGV[1].to_sym].call
    end

    private

		def task(name, &block)
    	@tasks[name] = block
    end

    def environment(name, &block)
      @environments[name] = block
    end

    def local(cmd)
      system cmd
      if $? != 0 # Check command exit status
        log "Local command failed: #{cmd}"
        exit(false)
      end
    end

    def remote(cmd)
      raise '`remote` is not implemented yet!'
    end

	end
end
