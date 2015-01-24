class Choice < ActiveRecord::Base
  has_many :responses
  has_many :surveys, :through => :responses
  has_many :questions, :through => :responses

end
