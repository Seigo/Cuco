class Project < ActiveRecord::Base
  has_many :tasks, :dependent => :destroy
  #belongs_to :user
  
  attr_accessor :task_cache
  
  validates_length_of :name, :in => 2..30, :allow_nil => false
  validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
  
  def count_pomos
    self.tasks.count(:all, :joins => :pomodoros)
  end
=begin
  def count_expected_pomos
    self.tasks.each do |t|
      count += t.expected_pomo
    end
    count
  end
=end
end
