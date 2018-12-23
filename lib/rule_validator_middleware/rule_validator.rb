# Middleware class
class RuleValidator
  attr_reader :request

  def initialize(appl)
    @appl = appl
    @pr = ParsingRule.new
    @validator = Validator.new(DbFactory.db(db))
  end

  def call(env)
    @env = env
    status, headers, body = @appl.call(env)
    if status == 200
      response_rack('200', 'Success', body)
    else
      call_validator? ? response_rack('200', 'Success', body) : response_rack('401', 'Failed', body)
    end
  end

  private

  def db
    ConfigLoad.load_file('../config/rules_db.yml')[:database]
  end

  def call_validator?
    @validator.valid?(ParsedRequest.new(@pr.route_object(path_info[1..-1])))
  end

  def response_rack(status, header, body)
    resp = Rack::Response.new
    resp.status = status
    resp.body = body
    resp.set_header('X-Auth-User', header)
    resp.finish
  end

  def path_info
    @env['PATH_INFO']
  end
end
