class CreateSurveys < ActiveRecord::Migration
  def change
  create_table :surveys do |t|
  	t.string :title
  	t.integer :author_id

    t.timestamp
  end
end
end
