module Exceptions
  class BaseException < RuntimeError; end
  class InvalidStorage < BaseException; end
end
