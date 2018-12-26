require_relative '../../lib/rule_validator_middleware/validator'
require_relative '../../lib/rule_validator_middleware/parsed_request'
require_relative '../../lib/rule_validator_middleware/storages/yaml'
require "test/unit"
require 'minitest/autorun'

class ValidatorTest < Minitest::Test

  def setup
    @storage = Storages::Yaml.new
    @validator = Validator.new(@storage)
    @request = ParsedRequest.new({
      report_in_company_bp: {
        id: 123,
        bp_id: 'abc123',
        report_id: 128
      }
    }, "GET")
    @failed_request = ParsedRequest.new({
      fail: {
        id: 1,
        bp_id: 'a',
        report_id: 1
      }
    }, "GET")
    @not_allowed_request = ParsedRequest.new({
      not_allowed_path: {
        id: 123,
        bp_id: 'abc123',
        report_id: 128
      }
    }, "GET")
  end

  def test_valid_request
    assert_equal true, @validator.valid?(@request)
  end

  def test_invalid_request
    assert_equal false, @validator.valid?(@failed_request)
  end

  def test_not_allowed_request_with_good_params
    assert_equal false, @validator.valid?(@not_allowed_request)
  end
end
