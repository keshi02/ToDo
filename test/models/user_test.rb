require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@exapmle.com")
  end
  # モデルが機能するかテスト
  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    # nilだけでなく空白も弾くかテストする
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "name should not be long " do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be long " do
    @user.email = "a" * 255
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
end
