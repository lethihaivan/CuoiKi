class ApplicationJob < ActiveJob::Base
	 def job_or_instantiate(*args) # :doc:
          args.first.is_a?(self) ? args.first : new(*args)
        end
	   def perform_later(*args)
        job_or_instantiate(*args).enqueue
      end
end
