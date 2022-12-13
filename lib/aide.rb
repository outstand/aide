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
      services[name] ||= Aide::Service.new(name: name)
    end

    def config
      @config ||= Aide::Config.new
    end

    def configure(&block)
      config.instance_eval(&block)
      load_services
    end

    def display_services
      puts "Aide Services (Using #{config.service_address_key}):"

      services.each do |name, service|
        puts "==> #{name}: #{formatted_service(service: service)}"
      end
    end

    private

    def load_services
      config.services.each_key do |name|
        service(name)
      end
    end

    def service_port(service:)
      service.port.nil? ? '' : ":#{service.port}"
    end

    def formatted_service(service:)
      "#{service.address}#{service_port(service: service)} #{service.display_url(filtered: true)}".strip
    end
  end
end
