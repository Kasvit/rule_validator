class BaseStorage

  def find_rule(rule_name)
    raise NotImplementedError
  end

  def add_rule(rule_name)
    raise NotImplementedError
  end
end
