class TodoDay < ActiveRecord::Base
  attr_accessible :date, :user_id, :task_list
end
