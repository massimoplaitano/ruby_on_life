class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :trackable, :confirmable, :lockable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :full_name
end
