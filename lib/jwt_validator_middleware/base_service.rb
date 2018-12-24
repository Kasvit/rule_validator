require_relative 'exceptions'

class BaseService
  def self.call(*args)
    new(*args).call
  end
end
