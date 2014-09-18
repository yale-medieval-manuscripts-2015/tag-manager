class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and  :trackable, :rememberable,
  devise :database_authenticatable, :registerable, :recoverable, :validatable
  devise :omniauthable, :omniauth_providers => [:cas]

  # Omniauth
  attr_accessible :provider, :uid, :name, :email, :password
end
