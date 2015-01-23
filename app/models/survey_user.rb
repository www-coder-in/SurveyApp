class SurveyUser < ActiveRecord::Base

  belongs_to :survey
  belongs_to :user

  validates :user, uniqueness: true

end
