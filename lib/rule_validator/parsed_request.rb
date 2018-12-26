module RuleValidator
  class ParsedRequest
    attr_reader :request_body, :request_method
    def initialize(request_body, request_method)
      @request_body = request_body
      @request_method = request_method
    end

    def name
      @request_body.keys[0].to_s
    end

    def params
      @request_body.values[0]
    end

    def incoming_method
      @request_method
    end
  end
end
