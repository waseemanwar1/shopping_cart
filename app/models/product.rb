class Product < ApplicationRecord
	has_many :line_items, dependent: :destroy

	mount_base64_uploader :image, AvatarUploader
end
