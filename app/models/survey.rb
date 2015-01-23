class Survey < ActiveRecord::Base
  belongs_to :users, foreign_key: :author_id  

end
