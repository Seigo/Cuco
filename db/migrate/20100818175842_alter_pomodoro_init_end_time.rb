class AlterPomodoroInitEndTime < ActiveRecord::Migration
  def self.up
    change_column :pomodoros, :init_time, :datetime
    change_column :pomodoros, :end_time, :datetime
  end

  def self.down
  end
end
