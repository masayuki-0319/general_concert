class User < ApplicationRecord
  has_many :music_posts, dependent: :destroy
  has_many :music_likes, class_name: 'MusicLike',
                         foreign_key: 'liker_id',
                         dependent: :destroy
  has_many :active_user_relationships, class_name: 'UserRelationship',
                                       foreign_key: 'follower_id',
                                       dependent: :destroy
  has_many :following, through: :active_user_relationships, source: :followed
  has_many :passive_user_relationships, class_name: 'UserRelationship',
                                        foreign_key: 'followed_id',
                                        dependent: :destroy
  has_many :followers, through: :passive_user_relationships, source: :follower
  attr_accessor :remember_token
  validates :name, presence: true, length: { maximum: 50 }
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続Session：ユーザをDBに記録
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 永続Session：TokenとDigestの一致確認
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # 永続Session：ログイン情報を破棄
  def forget
    update_attribute(:remember_digest, nil)
  end

  def feed
    MusicPost.where("user_id IN (:following_ids) OR user_id = :user_id",
                    following_ids: following_ids, user_id: id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_user_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # 動画いいね！機能
  def like(music_post)
    music_post_likes.create(music_post_id: music_post.id)
  end

  # 動画いいね！機能
  def unlike(music_post)
    music_post_likes.find_by(music_post_id: music_post.id).destroy
  end

  # 動画いいね！機能
  def liking?(music_post)
    !music_likes.find_by(id: music_post.id).nil?
  end
end
