class User < ActiveRecord::Base
  attr_accessor :password
  # attr_accessible :username, :email, :password, :password_confirmation
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  # validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create

	before_save :encrypt_password
	after_save :clear_password


	def encrypt_password
	  if password.present?
	    self.salt = BCrypt::Engine.generate_salt
	    self.encryptedPassword= BCrypt::Engine.hash_secret(password, salt)
	  end
	end
	def clear_password
	  self.password = nil
	end

	def self.authenticate(username="", login_password="")
	  user = User.find_by_name(username)
	  if user && user.match_password(login_password)
	    return user
	  else
	    return false
	  end
	end   

	def match_password(login_password="")
	  self.encryptedPassword == BCrypt::Engine.hash_secret(login_password, salt)
	end


end