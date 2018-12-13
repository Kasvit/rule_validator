require_relative '../lib/validator'
require_relative '../lib/parsed_request'
require_relative '../lib/storage'
require "test/unit"
require 'minitest/autorun'
require 'pry'

class ValidatorTest < Minitest::Test

  def setup
    @storage = Storage.new(RulesYamlFileProvider.load(filename = 'lib/storages/rules.yml'))
    @request = ParsedRequest.new( {
      report_in_company_bp: {
        id: 123,
        bp_id: 'abc123',
        report_id: 128 
      }
    })
  end

  def test_find_rule_from_storage
    rule = @storage.find_rule(@request.name)
    assert_equal "report_in_company_bp", rule[:resource]
  end

end