class Post < ApplicationRecord
    validates :title, :body, :author_id,  presence: true
    paginates_per 5
    has_one_attached :image
end
