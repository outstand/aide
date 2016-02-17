module Aide
  class Config
    attr_accessor :services

    def initialize
      @services = {}
    end

    def add_service(name:, url:)
      services[name] = {
        name: name,
        url: url
      }
    end

    def get_service(name:)
      services[name] || {}
    end
  end
end
