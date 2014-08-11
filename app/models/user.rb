class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collaborators, dependent: :destroy
  has_many :wikis, through: :collaborators
  has_many :original_wikis, class_name: "Wiki", dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def full_name
    first_name + " " + last_name
  end

  def role?(base_role)
    role == base_role.to_s
  end

  def status?(base_status)
    status == base_status.to_s
  end
end
