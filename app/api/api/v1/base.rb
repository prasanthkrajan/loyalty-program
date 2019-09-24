module API::V1
  class Base < API::Base
    version 'v1', using: :header

    format :json
  end
end