require 'minitest/autorun'
require_relative '../../../lib/rule_validator_middleware/storages/mongo_storage'

class MongoTest < Minitest::Test

  def setup
    @storage = MongoStorage.new
  end

  def test_true_on_rule_report_in_company_bp_in_storage
    rule = @storage.find_rule('report_in_company_bp')
    assert_equal rule[:resource], 'report_in_company_bp'
  end
end
