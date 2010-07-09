require 'test_helper'

class PomodoroTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Pomodoro.new.valid?
  end
end
