require_relative '../../lib/rule_validator/db_data_validator'
require_relative '../../lib/rule_validator/parsed_request'
require_relative '../../lib/rule_validator/storages/yaml'
require "test/unit"
require 'minitest/autorun'

class DbDataValidatorTest < Minitest::Test

  def setup
    @storage = RuleValidator::Storages::Yaml.new
    @db_data_validator = RuleValidator::DbDataValidator.new(@storage)
    @request = RuleValidator::ParsedRequest.new({
      report_in_company_bp: {
        id: 123,
        bp_id: 'abc123',
        report_id: 128
      }
    }, "GET")
    @failed_request = RuleValidator::ParsedRequest.new({
      fail: {
        id: 1,
        bp_id: 'a',
        report_id: 1
      }
    }, "GET")
    @not_allowed_request = RuleValidator::ParsedRequest.new({
      not_allowed_path: {
        id: 123,
        bp_id: 'abc123',
        report_id: 128
      }
    }, "GET")
    @request_for_all_methods = RuleValidator::ParsedRequest.new({
      path_with_all_methods: {
        id: 123,
        bp_id: 'abc123',
        report_id: 128
      }
    }, "PATCH")
  end

  def test_valid_request
    assert_equal true, @db_data_validator.valid?(@request)
  end

  def test_invalid_request
    assert_equal false, @db_data_validator.valid?(@failed_request)
  end

  def test_not_allowed_request_with_good_params
    assert_equal false, @db_data_validator.valid?(@not_allowed_request)
  end

  def test_valid_request
    assert_equal true, @db_data_validator.valid?(@request_for_all_methods)
  end
end
