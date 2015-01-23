class CreateSurveysusers < ActiveRecord::Migration
  def change
      create_table :survey_user do |t|
      t.integer :survey_id
      t.integer :user_id

      t.timestamp
    end
  end
end
