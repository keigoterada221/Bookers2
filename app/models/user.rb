class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :send_welcome_mail

  def send_welcome_mail
    ThanksMailer.user_welcome_mail(self).deliver
  end

  has_many :books,dependent: :destroy
  has_many :books_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy




# 自分がフォローしているユーザーの関連
  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「followings」と定義
  has_many :followings,through: :active_relationships, source: :follower


# 自分がフォローされるユーザーの関連
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers,through: :passive_relationships, source: :following
  # attachmentにはカラム名から_idを除いた名前を記述する
  attachment :profile_image




# https://teratail.com/questions/84523 参考
  validates :name, length: {in: 2..20}
  validates :introduction, length: { maximum: 50 }

  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.search(search, word)
        # 完全一致
        if word == "完全一致"
        @users = self.where(name: search)
        # 前方一致
        elsif word == "前方一致"
        @users = self.where("name LIKE ?","#{search}%")
        # 後方一致
        elsif word == "後方一致"
        @users = self.where("name LIKE ?","%#{search}")
        # 部分一致
        elsif word == "部分一致"
        @users = self.where("name LIKE ?","%#{search}%")
        else
        @users = self.all
        end
  end

  # 郵便番号での住所予測変換機能実装
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

end
