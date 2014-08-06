# TODO: Go over the following association

class User < ActiveRecord::Base
  has_many :owned_wikis, class: "Wiki"
  has_many :collborateWiki
  has_many :wikis, through: :collboratewiki
end
 
class Wiki < ActiveRecord::Base
  belongs_to :original_user, class_name: "User", foreign_key: "user_id" # might need to define the key.
  has_many :collboratewwiki
  has_many :Users, through: :CollborateWiki
end

class CollborateWiki < ActiveRecord::Base
  belongs_to :User
  belongs_to :Wiki
end

--------------------------------------

class User < ActiveRecord::Base
  has_many :wikis, through: :collaborators
end

class Wiki < ActiveRecord::Base
  belongs_to :original_user, class_name: "User", foreign_key: "user_id"
  has_many :users, through: :collaborators
end

class Collaborator < ActiveRecord::Base
  belongs_to :User
  belongs_to :Wiki
end

---------------------------------------

user:
  :first_name,
  :last_name,
  :email,
  :password,
  :role,
  :status

wiki:
  :title,
  :body
  :user_id

collaborator:
  :user_id
  :wiki_id
