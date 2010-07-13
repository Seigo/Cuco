class AlterPomodoroInterPercen < ActiveRecord::Migration
  def self.up
    remove_column :pomodoros, :percentage
    
    add_column    :pomodoros, :i_interruption, :integer, :default => 0, :limit => 2
    add_column    :pomodoros, :e_interruption, :integer, :default => 0, :limit => 2
  end

  def self.down
    add_column    :pomodoros, :percentage, :integer, :limit => 2
    
    remove_column :pomodoros, :i_interruption
    remove_column :pomodoros, :e_interruption
  end
end
