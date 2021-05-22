# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :coordinates
  has_one :reward
  has_many :payments

  after_create do
    Reward.create(user_id: id)
    Payment.create(user_id: id)
  end
end
