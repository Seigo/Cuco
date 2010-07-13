require 'test_helper'

class TodoDayTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert TodoDay.new.valid?
  end
end
