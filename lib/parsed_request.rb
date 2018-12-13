class ParsedRequest

  attr_reader :request_body

  def initialize(request_body)
    @request_body = request_body
  end

  def name
    @request_body.keys[0].to_s
  end

  def params
    @request_body.values[0]
  end
end