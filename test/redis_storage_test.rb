require_relative '../lib/storages/redis_storage'
require 'minitest/autorun'

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

  def test_true_on_add_new_resourse_in_storage
    @storage.add_rule('new_resourse', { resource: 'new_resourse',
                                        description: 'allow access to second resourse',
                                        params: { id: 123, bp_id: 'abc123', report_id: 128 },
                                        participant: {id: 123},
                                        methods: 'GET',
                                        action:  'allow' })

    rule = @storage.find_rule('new_resourse')
    assert_equal rule['resource'], 'new_resourse'
  end
end
