class User < ActiveRecord::Base
  attr_accessible  :login, :password
  validates_presence_of :login, :password
  validates_uniqueness_of :login
  def has_password?(submitted_password)
    password == submitted_password
  end

  def self.authenticate(login, submitted_password)
    user = find_by_login(login)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
end