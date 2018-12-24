require_relative '../../lib/my_app'
require_relative '../../lib/jwt_validator_middleware/jwt_validator'
require 'jwt'
require 'test/unit'
require 'rack/test'

class JwtValidatorTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    JwtValidator.new(MyApp.new)
  end

  def setup
    @payload = { "user": 1 }
    @algo    = 'HS256'
    @secret  = 'secret'

    @valid_token   = JWT.encode @payload, @secret, @algo
    @invalid_token = JWT.encode @payload, 'something else', @algo
  end

  def test_assert_equal_true_with_domen_auth_signup
    header 'Authorization', "Bearer #{@valid_token}"
    get 'https://auth.com/signup/name'

    assert_equal true, last_response.header.include?('X-Auth-User')
  end

  def test_assert_equal_true_with_domen_dots_signin
    header 'Authorization', "Bearer #{@valid_token}"

    get 'http://dots.com/signin'
    assert_equal true, last_response.header.include?('X-Auth-User')
  end

  def test_assert_equal_true_with_domen_dots_signin_id
    header 'Authorization', "Bearer #{@valid_token}"

    get 'http://dots.com/signin/id'
    assert_equal true, last_response.header.include?('X-Auth-User')
  end

  def test_assert_equal_false_with_domen_authh_signup
    header 'Authorization', "Bearer #{@invalid_token}"

    get 'https://auth.com/signup/name'
    assert_equal false, last_response.header.include?('X-Auth-User')
  end

  def test_assert_equal_false_with_domen_dots_signin
    header 'Authorization', "Bearer #{@invalid_token}"

    get 'http://dots.com/signin'
    assert_equal false, last_response.header.include?('X-Auth-User')
  end

  def test_assert_equal_false_with_domen_dots_signinn_id
    header 'Authorization', "Bearer #{@invalid_token}"

    get 'http://dots.com/signin/id'
    assert_equal false, last_response.header.include?('X-Auth-User')
  end
end
