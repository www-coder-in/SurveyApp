class Question < ActiveRecord::Base
  has_many :responses
  has_many :surveys, :through => :responses
  has_many :choices, :through => :responses

end
