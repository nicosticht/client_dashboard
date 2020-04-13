
class API::Root < Grape::API
  mount API::V1::Base
  # mount V2::Root (next version)
end
