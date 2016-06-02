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

    def display_services
      load_services

      puts "Aide Services (Using #{config.service_address_key}):"
      self.services.each do |name, service|
        puts "==> #{name}: #{service.address}#{service.port.nil? ? '' : ":#{service.port}"} #{service.url(filtered: true)}".strip
      end
    end

    private
    def load_services
      self.config.services.keys.each do |name|
        service(name)
      end
    end
  end
end
