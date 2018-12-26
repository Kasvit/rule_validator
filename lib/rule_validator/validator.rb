# Middleware class
module RuleValidator
  class Validator
    attr_reader :request
    def initialize(appl)
      @appl = appl
      @pr = RuleValidator::ParsingRoute::ParsingRule.new
      @validator = RuleValidator::DbDataValidator.new(RuleValidator::DbFactory.db(db))
    end

    def call(env)
      @env = env
      status, headers, body = @appl.call(env)
      if status == 200
        response_rack('200', headers['X-Auth-User'], body)
      elsif status == 401 && (headers['X-Auth-User'] || @env['HTTP_X_AUTH_USER'] )
        call_validator? ? response_rack('200', headers['X-Auth-User'], body) : response_rack('401', 'Failed', body)
      else
        response_rack('401', 'Failed', body)
      end
    end

    private

    def db
      ConfigLoad.load_file('../config/rules_db.yml')[:database]
    end

    def call_validator?
      @validator.valid?(ParsedRequest.new(@pr.route_object(path_info[1..-1]), request_method))
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

    def request_method
      @env['REQUEST_METHOD']
    end
  end
end
