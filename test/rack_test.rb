require_relative '../lib/my_app'
require_relative '../lib/myrackmiddleware'
require_relative '../lib/config_load'
require_relative '../lib/white_list_checker'
require_relative '../lib/parsing_rule'
require_relative '../lib/db_factory'
require_relative '../lib/storages/yaml_file_storage'
require_relative '../lib/storages/redis_storage'
require_relative '../lib/storages/mongo_storage'
require_relative '../lib/validator'
require 'test/unit'
require 'rack/test'
# Test

class RackWhitelistTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    RuleValidator.new(MyApp.new, $select_db[0])
  end

  def test_status_401_with_without_token
    get '/'
    assert_equal last_response.status, 401
  end

  def test_status_200_with_domen_auth_signup
    get 'http://auth.com/signup'
    assert_equal(last_response.status, 200)
  end

  def test_exception_with_domen_auth_signupp
    assert_raises(RuntimeError) { get 'http://auth.com/signupp' }
  end

  def test_status_200_with_domen_resources_countries_method_get
    get 'http://resources.com/countries'
    assert_equal(last_response.status, 200)
  end

  def test_exception_with_domen_resources_countriess_method_get
    assert_raises(RuntimeError) { get 'http://resources.com/countriess' }
  end

  def test_status_200_with_domen_dots_test_method_get
    get 'http://dots.com/test'
    assert_equal(last_response.status, 200)
  end

  def test_exception_with_domen_dots_tests_method_get
    assert_raises(RuntimeError) { get 'http://dots.com/tests' }
  end

  def test_status_200_with_domen_dots_test_method_post
    post 'http://dots.com/test'
    assert_equal(last_response.status, 200)
  end

  def test_exception_with_domen_dots_testt_method_post
    assert_raises(RuntimeError) { post 'http://dots.com/testt' }
  end

  def test_status_200_with_domen_dots_signin
    get 'http://dots.com/signin'
    assert_equal(last_response.status, 200)
  end

  def test_status_200_with_domen_dots_signin_id
    get 'http://dots.com/signin/id'
    assert_equal(last_response.status, 200)
  end

  def test_status_401_with_domen_dots_signinn_id
    assert_raises(RuntimeError) { get 'http://dots.com/signinn/id' }
  end

  def test_status_200_with_domen_dotss_route_account_workspaces_12_members_admin
    get 'http://dotss.com/account/workspaces/12/members/admin'
    assert_equal(last_response.status, 200)
  end

  def test_status_401_with_domen_dotss_route_account_workspaces_122_members_admin
    get 'http://dotss.com/account/workspaces/122/members/admin'
    assert_equal(last_response.status, 401)
  end
end

$select_db = ARGV.dup