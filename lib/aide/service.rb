module Aide
  class Service
    attr_accessor :name

    def initialize(name:)
      @name = name
    end

    delegate :Address, :ServiceAddress, :ServicePort, to: :service

    def address
      send(Aide.config.service_address_method)
    end

    alias port ServicePort

    def url(filtered: false)
      return if empty?

      template = config[:url]
      return if template.nil?

      template = template.dup
      template.gsub!(/{{\.protocol}}/, self.protocol.to_s)
      template.gsub!(/{{\.address}}/, self.address.to_s)
      template.gsub!(/{{\.Address}}/, self.Address.to_s)
      template.gsub!(/{{\.ServiceAddress}}/, self.ServiceAddress.to_s)
      template.gsub!(/{{\.ServicePort}}/, self.ServicePort.to_s)
      template.gsub!(/{{\.port}}/, self.port.to_s)
      template.gsub!(/{{\.auth}}/, self.auth(filtered: filtered).to_s)

      template
    end

    def url!
      self.url.tap do |orig_url|
        raise MissingService.new(name) if orig_url.nil?
      end
    end

    def auth(filtered: false)
      template = config[:auth]

      if template.nil? || self.user.nil? || self.password.nil?
        return
      end

      template = template.dup
      template.gsub!(/{{\.user}}/, self.user.to_s)

      password = nil
      if filtered
        password = 'PASSWORD'
      else
        password = self.password.to_s
      end

      template.gsub!(/{{\.password}}/, password)

      template
    end

    def user_key
      config[:user_key]
    end

    def user
      return if user_key.nil?

      @user ||= begin
                      user = Diplomat::Kv.get(user_key, {}, :return)
                      user = nil if user == ""
                      user
                    end
    end

    def password_key
      config[:password_key]
    end

    def password
      return if password_key.nil?

      @password ||= begin
                      password = Diplomat::Kv.get(password_key, {}, :return)
                      password = nil if password == ""
                      password
                    end
    end

    def protocol_key
      config[:protocol_key]
    end

    def protocol
      return if protocol_key.nil?

      @protocol ||= begin
                      protocol = Diplomat::Kv.get(protocol_key, {}, :return)
                      protocol = nil if protocol == ""
                      protocol
                    end
    end

    def empty?
      service.to_h.empty?
    end

    private
    def service
      @service ||= Diplomat::Service.get(name)
    end

    def config
      @config ||= Aide.config.get_service(name: name)
    end
  end
end
