class Wiki < ActiveRecord::Base
  belongs_to :original_user, class_name: "User", foreign_key: "user_id"
  has_many :collaborators
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }

  scope :visible_to, -> (user) { user ? all : where(private: false) }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :original_user, presence: true

end
