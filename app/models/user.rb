class User < ApplicationRecord
  belongs_to :household, optional: true
  has_many :chores
  has_one_attached :profile_picture
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :attach_default_profile_picture

  def avatar_url
    if profile_picture.attached?
      profile_picture
    elsif default_avatar.present?
      ActionController::Base.helpers.asset_path("avatars/#{default_avatar}")
    else
      ActionController::Base.helpers.asset_path("avatars/default_avatar.png")
    end
  end

  private

  def attach_default_profile_picture
    return if profile_picture.attached?

    default_image_path = Rails.root.join("app/assets/images/avatars/default_avatar.png")
    profile_picture.attach(
      io: File.open(default_image_path),
      filename: "default_avatar.png",
      content_type: "image/png"
    )
  end
end
