require_relative 'config_load'
require_relative 'tree'
require_relative 'node'

class ParsingRule
  def initialize
    @routes = ConfigLoad.load_file('../config/tree_routes.yml')
    @tree = Tree.new
    @routes.each { |route| @tree.add_route(route[1], route[0]) }
  end

  def get_route_object(route)
    ro = @tree.route_obj
    return { ro['name'].to_sym => ro.delete_if{|key, value| key == 'name' } } if @tree.include?(route)

    raise 'Route missing'
  end
end
