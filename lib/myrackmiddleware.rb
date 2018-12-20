require_relative 'parsing_rule'
require_relative 'validator'
require_relative 'storages/yaml_file_storage'

class MyRackMiddleware
  attr_reader :request

  def initialize(appl)
    @appl = appl
    @pr = ParsingRule.new
    @validator = Validator.new(YamlFileStorage.new)
  end

  def call(env)
    @env = env
    @check_wl = WhiteListChecker.new(http_host, path_info, request_method)
    if @check_wl.host_present?
      response_rack("200", "Success")
    elsif path_info == '/'
      response_rack("401", "Failed")
    else
      call_validator? ? response_rack("200", "Success") : response_rack("401", "Failed")
    end
  end

  private

  def call_validator?
    @validator.valid?(ParsedRequest.new(@pr.get_route_object(path_info[1..-1])))
  end

  def response_rack(status, header)
    resp = Rack::Response.new
    resp.status = status
    resp.set_header("X-Auth-User", header)
    resp.finish
  end

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
