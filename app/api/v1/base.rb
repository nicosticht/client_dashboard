class API::V1::Base < Grape::API
  prefix 'api'
  format :json
  version 'v1', using: :path
  mount API::V1::Companies
end
