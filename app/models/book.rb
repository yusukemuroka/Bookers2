class Book < ApplicationRecord
    belongs_to :user
    has_many :book_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    validates :body, length: { maximum: 200 }, presence: true
    validates :title, presence: true

    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
      end
end
