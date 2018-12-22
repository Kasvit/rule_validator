# Middleware class
class WhiteLIstValidator
  attr_reader :request

  def initialize(appl)
    @appl = appl

  end

  def call(env)
    @env = env
    @check_wl = WhiteListChecker.new(http_host, path_info, request_method)
    if @check_wl.host_present?
      response_rack('200', 'Success')
    elsif path_info == '/'
      response_rack('401', 'Failed')
    else
      call_validator? ? response_rack('200', 'Success') : response_rack('401', 'Failed')
    end
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
