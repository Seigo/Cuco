class CreatePomodoros < ActiveRecord::Migration
  def self.up
    create_table :pomodoros do |t|
      t.integer :user_id, :null => false
      t.integer :task_id, :null => false
      t.time :init_time
      t.time :end_time
      t.integer :percentage, :limit => 2
      t.string :comment, :limit => 140
      #t.timestamps
      t.datetime "created_at"
    end
  end
  
  def self.down
    drop_table :pomodoros
  end
end
