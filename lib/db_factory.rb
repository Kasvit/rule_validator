# DataBase factory
class DbFactory
  def self.get_db(db = 'yaml')
    db = 'yaml' if db.nil?
    if db == 'yaml'
      YamlFileStorage.new
    elsif db == 'redis'
      RedisStorage.new
    elsif db == 'mongo'
      MongoStorage.new
    else
      raise 'DBFactory error'
    end
  end
end
