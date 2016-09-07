class Question < ApplicationRecord
  #this associates the question with answer in a one-to-many fashion
  #this will give us handy methods to easily created associated answers and fetch associated answers as well.
  #note that it should be pluralized for one to many associate.

  #you should also add a dependent option. The value can be:
  #destroy: will delete associated answers before deleting a question.
  #nullify: will make question_id 'null' for associated answers before deleting.
  has_many :answers, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  has_many :votes, dependent: :destroy
  has_many :voting_users, through: :votes, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  belongs_to :user

  validates :title, presence: true, uniqueness: {message: "must be unique, yo."}
  validates :body,  presence: {message: "must have a body, yo."}, length: {minimum: 5}

  # This validates that the title/body combination is unique - meaning that title nor body doesn't have to be unique by itself, but combo does
  # validates: body, uniqueness: {scope: :title}

  # VALID_EMAIL_REGEX = /^([a-zA-Z0-9_-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)|(([a-zA-Z0-9-]+.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(]?)$/
  # validates :email, format: VALID_EMAIL_REGEX

  #making own custom validation. It takes first argument which in this case is a private method

  validate :no_monkey
  after_initialize :set_views_defaults
  before_validation :capitalize_title

  def titleized_title
    title.titleize
  end

  scope :search, lambda {|keyword| where "title ILIKE ? OR body ILIKE ?","%#{keyword}%", "%#{keyword}%" }
  # def self.search(keyword)
  #   where "title ILIKE ? OR body ILIKE ?","%#{keyword}%", "%#{keyword}%"
  # end

  # scope :recent_ten, lambda {order(created_at: :desc).limit(10)}
  def self.recent_ten
    order(created_at: :desc).limit(10)
  end

  def like_for(user)
    likes.find_by_user_id user
  end

  def vote_for(user)
    votes.find_by_user_id user
  end

  def vote_value
    # votes.where(is_up: true).count - votes.where(is_up: false).count
    votes.up.count - votes.down.count
  end

  private

  def no_monkey
    if title && title.downcase.include?("monkey")
      errors.add(:title, "No monkey please")
    end
  end

  def set_views_defaults
    self.view_count ||= 0
  end

  def capitalize_title
    self.title.include?(' ') ? self.title.split(' ').each{|x| x.capitalize!}.join(' ') : self.title.capitalize!
  end

end
