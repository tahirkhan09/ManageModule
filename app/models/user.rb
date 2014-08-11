class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#,   :validatable

  has_many :roles_users, :dependent => :destroy
  has_many :roles, :through => :roles_users
  has_many :events

end
