class Question < ActiveRecord::Base
  # belongs_to :survey, :through => :responses
  has_many :responses
  # has_many :surveys, :through => :responses
  has_many :choices, :through => :responses

end
