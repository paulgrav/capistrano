module Capistrano
  class ServerDefinition
    attr_reader :host
    attr_reader :user
    attr_reader :port
    attr_reader :options

    def initialize(string, options={})
      @user, @host, @port = string.match(/^(?:([^;,:=]+)@|)(.*?)(?::(\d+)|)$/)[1,3]

      @options = options.dup
      user_opt, port_opt = @options.delete(:user), @options.delete(:port)

      @user ||= user_opt
      @port ||= port_opt

      @port = @port.to_i if @port
    end

    # Redefined, so that Array#uniq will work to remove duplicate server
    # definitions, based solely on their host names.
    def eql?(server)
      host == server.host &&
        user == server.user &&
        port == server.port
    end

    alias :== :eql?

    # Redefined, so that Array#uniq will work to remove duplicate server
    # definitions, based solely on their host names.
    def hash
      @hash ||= [host, user, port].hash
    end
  end
end