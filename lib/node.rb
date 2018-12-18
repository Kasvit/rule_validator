class Node
  attr_reader   :next, :type
  attr_accessor :route, :value, :name

  def initialize(value)
    @name = ''
    @route = false
    @next  = []
    @type = value.start_with?(':') ? :pattern : :exact
    @value = value
  end

  def validate_value?(word)
    if type == :pattern
      valid_pattern(word)
    else
      valid_exact?(word)
    end
  end

  def valid_exact?(word)
    value == word
  end

  def valid_pattern(word)
    return { value => word, 'name' => name } if route

    { value => word }
  end
end
