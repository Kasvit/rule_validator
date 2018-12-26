require_relative 'exceptions'
# DataBase factory
class DbFactory
  def self.db(db = 'yaml')
    Object.const_get("Storages::#{db.capitalize}").new
    rescue NameError
      raise Exceptions::InvalidStorage, "invalid storage #{db.capitalize}"
  end
end
