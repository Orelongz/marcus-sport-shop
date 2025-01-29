class UserSerializer
  include Alba::Resource

  root_key :user, :users

  attributes :id, :name, :email
end
