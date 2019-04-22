class PetSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :size, :gender, :breed
end
