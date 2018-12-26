module ParsingRoute
  class Tree
    attr_reader :route_obj

    def initialize
      @root = ParsingRoute::Node.new('*')
      @route_obj = {}
    end

    def add_route(route, name)
      words = route.split('/')
      base = @root
      words.each { |word| base = add_word(word, base.next) }
      base.route = true
      base.name  = name
    end

    def add_word(word, tree)
      tree.find { |n| n.value == word } || add_node(word, tree)
    end

    def add_node(word, tree)
      ParsingRoute::Node.new(word).tap { |new_node| tree << new_node }
    end

    def find_route(route)
      words = route.split('/')
      base  = @root
      word_found =
        words.all? { |word| base = find_word(word, base.next) }
      yield word_found, base if block_given?
      base
    end

    def find_word(word, tree)
      tree.find { |n| create_obj(n.validate_value?(word)) }
    end

    def create_obj(value)
      if value.is_a?(Hash)
        @route_obj.merge!(value)
      else
        value
      end
    end

    def include?(route)
      find_route(route) { |found, base| return found && base.route }
    end
  end
end
