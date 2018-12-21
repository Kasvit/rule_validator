# DataBase factory
class DbFactory
  def self.get_db(db = 'yaml')
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
