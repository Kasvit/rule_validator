require_relative '../lib/storages/redis_storage'

require 'minitest/autorun'
require "pry"

class RedisStorageTest < Minitest::Test
  def setup
    @storage = RedisStorage.new
  end

  def test_true_on_rule_report_in_company_bp_in_storage
    rule = @storage.find_rule('report_in_company_bp')
    assert_equal rule['resource'], 'report_in_company_bp'
  end

  def test_true_on_rule_second_resourse_in_storage
    rule = @storage.find_rule('second_resourse')
    assert_equal rule['resource'], 'second_resourse'
  end
end
