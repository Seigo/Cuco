class AddTaskOverall < ActiveRecord::Migration
  def self.up
    add_column :tasks, :overall, :text, :default => ""
    add_column :tasks, :expected_pomo, :integer
  end

  def self.down
    remove_column :tasks, :overall
    remove_column :tasks, :expected_pomo
  end
end
