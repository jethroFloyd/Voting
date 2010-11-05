class PollQuestionAddWeight < ActiveRecord::Migration
  def self.up
    change_table :polls_questions do |t|
      t.integer :weight, :default => 0
    end
  end

  def self.down
    change_table :polls_questions do |t|
      remove_column :polls_questions, :weight
    end
  end
end
