class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :articles

  #validates :email, presence: true, uniqueness: true
  #validates :password, presence: true, length: { minimum: 6 }
            
end
