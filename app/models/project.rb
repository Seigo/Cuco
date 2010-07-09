class Project < ActiveRecord::Base
  has_many :tasks, :dependent => :destroy
  belongs_to :user
  
  validates_length_of :name, :in => 2..30, :allow_nil => false
  validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
  
end
