require 'bcrypt'

class User < ActiveRecord::Base
	include BCrypt
	has_many :surveys
	has_many :survey_users
	has_many :responses, :through => :surveys

	attr_accessor :password
	before_save :password
	validates :username, uniqueness: true


	def password
		@password ||= Password.new(password_hash)
	end

	def password=(new_password)
		@password = Password.create(new_password)
		self.password_hash = @password
	end


end
