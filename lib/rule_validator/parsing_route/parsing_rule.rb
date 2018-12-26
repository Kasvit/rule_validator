require_relative '../../config_load'
require_relative 'tree'
require_relative 'node'
require_relative '../exceptions'

module RuleValidator
  module ParsingRoute
    class ParsingRule

      def initialize
        @routes = ConfigLoad.load_file('../config/tree_routes.yml')
        @tree = RuleValidator::ParsingRoute::Tree.new
        @routes.each { |route| @tree.add_route(route[1], route[0]) }
      end

      def route_object(route)
        ro = @tree.route_obj
        return { ro['name'].to_sym => ro.delete_if{|key| key == 'name' } } if @tree.include?(route)

        raise RuleValidator::Exceptions::RouteMissing
      end
    end
  end
end
