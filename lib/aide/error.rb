module Aide
  class Error < StandardError; end
  class MissingService < Error
    def initialize(service_name)
      super("Missing required service: #{service_name.inspect}")
    end
  end
end
