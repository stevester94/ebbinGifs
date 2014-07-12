class User < ActiveRecord::Base
  attr_accessor :password
  # attr_accessible :username, :email, :password, :password_confirmation
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  # validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 5..20, :on => :create

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
	  elsif !user
	    return "User does not exist"
		else
			return "incorrect password"
		end

	end   

	def match_password(login_password="")
	  self.encryptedPassword == BCrypt::Engine.hash_secret(login_password, salt)
	end


end