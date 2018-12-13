require_relative '../lib/validator'
require_relative '../lib/parsed_request'
require_relative '../lib/storage'
require "test/unit"
require 'minitest/autorun'
require 'pry'

class ValidatorTest < Minitest::Test

  def setup
    @storage = Storage.new(RulesYamlFileProvider.load(filename = 'lib/storages/rules.yml'))
    @validator = Validator.new(@storage)
    @request1 = ParsedRequest.new({
      report_in_company_bp: {
        id: 123,
        bp_id: 'abc123',
        report_id: 128 
      }
    })
    @request2 = ParsedRequest.new({
      fail: {
        id: 1,
        bp_id: 'a',
        report_id: 1 
      }
    })
  end

  def test_valid_request
    assert_equal true, @validator.valid?(@request1)
  end

  def test_invalid_request
    assert_equal false, @validator.valid?(@request2)
  end
end