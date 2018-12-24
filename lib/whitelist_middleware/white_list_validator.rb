# Middleware class
require 'pry'
class WhiteListValidator
  attr_reader :request

  def initialize(appl)
    @appl = appl
  end

  def call(env)
    @env = env
    status, headers, body = @appl.call(env)
    @check_wl = WhiteListChecker.new(http_host, path_info, request_method)
    @check_wl.host_present? ? status = 200 : status = 401
    [status, headers, body]
  end

  private

  def request_method
    @env['REQUEST_METHOD']
  end

  def http_host
    @env['HTTP_HOST']
  end

  def path_info
    @env['PATH_INFO']
  end
end
