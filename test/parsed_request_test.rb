require_relative '../lib/parsed_request'

require "test/unit"
require 'minitest/autorun'

class ValidatorTest < Minitest::Test

  def setup
    @request = ParsedRequest.new( {
      report_in_company_bp: {
        id: 123,
        bp_id: 'abc123',
        report_id: 128 
      }
    })
  end

  def test_parsed_request_name
    assert_equal "report_in_company_bp", @request.name
  end

end