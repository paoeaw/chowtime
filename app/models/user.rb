class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: true
  has_many :meal_plans

  mount_uploader :photo, PhotoUploader

  def cooked_count
    count = 0
    self.meal_plans.each do |plan|
      count += plan.meals.where(cooked: true).count
    end
    count
  end

  def active_plan
    self.meal_plans.last
  end
end
