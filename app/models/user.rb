class User < ApplicationRecord
	has_secure_password

	validates :full_name, presence: true, length: {maximum: 100}
	validates :username, presence: true, length: {maximum: 20}, uniqueness: {case_sensitive: true}
	validates :password, length: {minimum: 6}
	validates :role, presence: true

	has_many :albums
	#belongs_to :role

end
