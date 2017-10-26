class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :book_tours, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  before_save{email.downcase!}

  enum role: [:admin, :member]

  validates :name,  presence: true, length: {maximum: Settings.user.name_length}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.email_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.user.password_length}, allow_nil: true

  validates :address,
    presence: true, length: {maximum: Settings.user.address_length}

  VALID_PHONE_REGEX = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3,4})\2([0-9]{4})/
  validates :telphone, length: {maximum: Settings.user.telphone_length},
    format: {with: VALID_PHONE_REGEX}
  validate  :avatar_size

  private

  # Validates the size of an uploaded picture.
  def avatar_size
    if avatar.present? && avatar.size > Settings.user.avatar_size.megabytes
      errors.add :avatar,
        I18n.t("users.error_size_avatar", size: Settings.user.avatar_size)
    end
  end
end
