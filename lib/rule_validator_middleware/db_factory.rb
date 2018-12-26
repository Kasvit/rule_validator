# DataBase factory
class DbFactory
  def self.db(db = 'yaml')
    Object.const_get("Storages::#{db.capitalize}").new
  end
end
