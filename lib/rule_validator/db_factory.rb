require_relative 'exceptions'
# DataBase factory
module RuleValidator
  class DbFactory
    def self.db(db = 'yaml')
      Object.const_get("RuleValidator::Storages::#{db.capitalize}").new
      rescue NameError
        raise RuleValidator::Exceptions::InvalidStorage, "invalid storage #{db.capitalize}"
    end
  end
end
