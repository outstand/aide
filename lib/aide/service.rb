module Aide
  class Service
    attr_accessor :name

    def initialize(name:)
      @name = name
    end

    delegate :Address, :ServiceAddress, :ServicePort, to: :service

    def url
      template = Aide.config.get_service(name: name)[:url]
      return if template.nil?

      template = template.dup
      template.gsub!(/{{\.Address}}/, self.Address.to_s)
      template.gsub!(/{{\.ServiceAddress}}/, self.ServiceAddress.to_s)
      template.gsub!(/{{\.ServicePort}}/, self.ServicePort.to_s)

      template
    end

    def url!
      self.url.tap do |orig_url|
        raise MissingService if orig_url.nil?
      end
    end

    private
    def service
      @service ||= Diplomat::Service.get(name)
    end
  end
end