class Pomodoro < ActiveRecord::Base
  attr_accessible :user_id, :task_id, :init_time, :end_time, :comment, :i_interruption, :e_interruption
  
  belongs_to :user
  belongs_to :task
  
  validates_presence_of :task_id, :user_id, :init_time, :end_time, :percentage
  validate :check_dates, :check_ownage
  
  before_save :cap_percentage
  
  def cap_percentage
    self.percentage = 100 if self.percentage > 100.0
    self.percentage = 0 if self.percentage < 0
  end
  
  
  def check_dates
    # TODO the init_time must be less then the end_time
    true
  end
  
  def check_ownage
    # TODO check the references, if the task is existent and current_user's own
    true
  end
  
end
