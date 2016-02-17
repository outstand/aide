require 'aide/version'
require 'aide/error'
require 'aide/config'
require 'aide/service'

module Aide
  class << self
    def services
      @services ||= {}
    end
    attr_writer :services

    def service(name)
      self.services[name] ||= Aide::Service.new(name: name)
    end

    def config
      @config ||= Aide::Config.new
    end

    def configure(&block)
      self.config.instance_eval(&block)
    end
  end
end
