class ExpensesCategorySerializer < ActiveModel::Serializer
  attributes :name,
             :description
end
