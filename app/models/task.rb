class Task < ActiveRecord::Base
  has_many :pomodoros
  belongs_to :project
  belongs_to :user
  
  validates_length_of :name, :in => 2..30, :allow_nil => false
  validates_uniqueness_of :name, :scope => [:user_id, :project_id], :case_sensitive => false
  
end
