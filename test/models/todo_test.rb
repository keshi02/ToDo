require "test_helper"

class TodoTest < ActiveSupport::TestCase
  def setup
    @user = users(:jack)
    @todo = @user.todos.build(title: "title", content: "content", status: 0)
  end

  test "should be valid" do
    assert @todo.valid?
  end

  test "title should be present" do
    @todo.title = "  "
    assert_not @todo.valid?
  end

  test "title should not be long" do
    @todo.title = "a" * 51
    assert_not @todo.valid?
  end

  test "content should not be long" do
    @todo.content = "a" * 255
    assert_not @todo.valid?
  end
end
