class Survey < ActiveRecord::Base
  belongs_to :users, foreign_key: :author_id
  has_many :responses
  has_many :questions, :through => :responses
  has_many :survey_users

end
