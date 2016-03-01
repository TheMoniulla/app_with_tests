class GroupSerializer < ActiveModel::Serializer
  attributes :name,
             :owner_id
end
