class Book < ApplicationRecord

	belongs_to :user
	attachment :profile_image
	has_many :books_comments,dependent: :destroy
	has_many :favorites,dependent: :destroy

	validates :title, presence: true
    validates :body, presence: true, length: { maximum: 200 }

    # 解説はメモしている
    def favorite_by?(user)
    	favorites.where(user_id: user.id).exists?
    end

    def self.search(search, word)
    # 完全一致
        if word == "完全一致"
        @books = self.where(title: search)
        # 前方一致
        elsif word == "前方一致"
        @books = self.where("title LIKE ?","#{search}%")
        # 後方一致
        elsif word == "後方一致"
        @books = self.where("title LIKE ?","%#{search}")
        # 部分一致
        elsif word == "部分一致"
        @books = self.where("title LIKE ?","%#{search}%")
        else
        @books = self.all
        end
    end
end
