require_relative '../../lib/my_app'
require_relative '../../lib/rule_validator_middleware/rule_validator'
require_relative '../../lib/config_load'
require_relative '../../lib/rule_validator_middleware/parsing_route/parsing_rule'
require_relative '../../lib/rule_validator_middleware/db_factory'
require_relative '../../lib/rule_validator_middleware/storages/yaml_file_storage'
require_relative '../../lib/rule_validator_middleware/storages/redis_storage'
require_relative '../../lib/rule_validator_middleware/storages/mongo_storage'
require_relative '../../lib/rule_validator_middleware/validator'
require 'test/unit'
require 'rack/test'

# Tests
class RuleValidatorTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    RuleValidator.new(MyApp.new)
  end

  # def test_status_200_with_domen_dotss_route_account_workspaces_12_members_admin
  #   get 'http://dotss.com/account/workspaces/12/members/admin'

  #   assert_equal(last_response.status, 200)
  # end

  def test_status_401_with_domen_dotss_route_account_workspaces_122_members_admin
    get 'http://dotss.com/account/workspaces/122/members/admin'

    assert_equal(last_response.status, 401)
  end
end
