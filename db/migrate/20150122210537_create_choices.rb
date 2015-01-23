class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :description

      t.timestamp
    end
  end
end