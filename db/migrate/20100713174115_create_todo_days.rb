class CreateTodoDays < ActiveRecord::Migration
  def self.up
    create_table :todo_days do |t|
      t.date :date
      t.integer :user_id
      t.text :task_list
      t.timestamps
    end
  end
  
  def self.down
    drop_table :todo_days
  end
end
