class Article < ApplicationRecord
	enum category: [:adventure, :classic, :crime, :poetry, :action, :horror]
	has_one_attached :image
	has_one_attached :bodypdf

	validate :image_type

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy

	validates :title, presence: true
	validates :user_id, :presence => true
	scope :desc, -> { order(created_at: :desc) }

	private

	def image_type
		if image.attached? == false
			errors.add(:image, "is missing!")
		end
	end
end
