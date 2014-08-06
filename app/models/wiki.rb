class Wiki < ActiveRecord::Base
  belongs_to :user

  default_scope { order('created_at DESC') }

  scope :visible_to, -> (user) { user ? all : where(private: false) }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true

  def publish_settings
    type_of_publish = []
    type_of_publish << [draft: draft] << [publish: publish] << [scheduled: scheduled]
  end
end
