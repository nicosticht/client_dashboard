class API::Entities::V1::Company < Grape::Entity
  expose :id
  expose :identity
  expose :name
  expose :created_at
  expose :employees_amount
  expose :clients_amount
  expose :contractors_amount
end
