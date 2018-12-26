module RuleValidator
  module Exceptions
    class BaseException  < RuntimeError; end
    class InvalidStorage < BaseException; end
    class RouteMissing   < BaseException; end
  end
end
