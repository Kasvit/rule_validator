require 'minitest/autorun'
require_relative '../lib/parsing_rule'

class ParsingRuleTest < Minitest::Test
  def setup
    @pr = ParsingRule.new
  end

  def test_object_on_valid_route_1
    assert_equal @pr.get_route_object('account/workspaces/12/members/admin'),
     { account_workspaces_members:{":workspace_id"=>"12", ":id"=>"admin"} }
  end

  def test_raise_on_not_valid_route_1
    assert_raises(RuntimeError) do
      @pr.get_route_object('account/workspacess/12/members/admin')
    end
  end

  def test_object_on_valid_route_2
    assert_equal @pr.get_route_object('account/task/5'),
      { account_task: {":id"=>"5"} }
  end

  def test_raise_on_not_valid_route_2
    assert_raises(RuntimeError) do
      @pr.get_route_object('account/taskk/5')
    end
  end
end
