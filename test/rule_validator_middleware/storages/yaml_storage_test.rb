require_relative '../../../lib/rule_validator_middleware/storages/yaml_file_storage'

require 'minitest/autorun'

class YamlStorageTest < Minitest::Test
  def setup
    @storage = YamlFileStorage.new
  end

  def test_true_on_rule_report_in_company_bp_in_storage
    rule = @storage.find_rule('report_in_company_bp')
    assert_equal rule[:resource], 'report_in_company_bp'
  end

  def test_true_on_rule_second_resourse_in_storage
    rule = @storage.find_rule('fake')
    assert_equal rule[:resource], 'fake'
  end
end
