class Travel < ApplicationRecord
  belongs_to :place_from, class_name: Place.name, foreign_key: :id_place_from
  belongs_to :place_to, class_name: Place.name, foreign_key: :id_place_to
  belongs_to :promotion, optional: true
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tours, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.travel.name_length}
  validates :place_from, presence: true
  validates :place_to, presence: true
  validates :price, presence: true,
    numericality: {greater_than: Settings.travel.price_greater}
  validates :schedule, presence: true
  validates :description, presence: true
  validate :check_not_sam_two_places

  scope :order_created_desc, ->{order created_at: :desc}

  scope :by_place_from, ->place_form do
    where id_place_from: place_form if place_form.present?
  end

  scope :by_place_to, ->place_to do
    where id_place_to: place_to if place_to.present?
  end

  scope :by_price_max_range, ->max{where("price >= ?", max)}

  scope :by_price_between_range, ->range_price do
    where("price between ? and ?", range_price.first, range_price.last)
  end

  scope :by_date_of_tours, -> date do
    joins(:tours).where("tours.date_start = DATE(?)", date) if date.present?
  end

  def average_rating
    return Settings.number_star_default if ratings.nil?
    ratings.average(:star_number).to_f.round I18n.t "number.decimal_digit"
  end

  def check_not_sam_two_places
    if id_place_from == id_place_to
      errors.add I18n.t("admin.travels.edit.place_form"),
        I18n.t("admin.travels.edit.msg_place_not_same")
    end
  end
end
