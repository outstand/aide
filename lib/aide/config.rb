module Aide
  class Config
    attr_accessor :services,
      :service_address_key,
      :service_address_method

    ADDRESS_KEY = '.Address'.freeze
    ADDRESS_METHOD = :Address
    SERVICE_ADDRESS_KEY = '.ServiceAddress'.freeze
    SERVICE_ADDRESS_METHOD = :ServiceAddress

    def initialize
      @services = {}
      @service_address_key = ADDRESS_KEY
      @service_address_method = ADDRESS_METHOD
    end

    def use_address!
      self.service_address_key = ADDRESS_KEY
      self.service_address_method = ADDRESS_METHOD
    end

    def use_service_address!
      self.service_address_key = SERVICE_ADDRESS_KEY
      self.service_address_method = SERVICE_ADDRESS_METHOD
    end

    def add_service(name:, url:nil, auth:nil, user_key:nil, password_key:nil, protocol_key:nil)
      services[name] = {
        name: name,
        url: url,
        auth: auth,
        user_key: user_key,
        password_key: password_key,
        protocol_key: protocol_key
      }
    end

    def get_service(name:)
      services[name] || {}
    end
  end
end
