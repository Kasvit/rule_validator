module JwtValidatior
  module Exceptions
    class BaseException < RuntimeError; end
    class InvalidAlgorithm < BaseException; end
  end
end
