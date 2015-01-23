class CreateResponses < ActiveRecord::Migration
  def change
      create_table :responses do |t|
      t.integer :survey_id
      t.integer :question_id
      t.integer :choice_id
      t.integer :vote_count, :default => 0

      t.timestamp
    end
  end
end
