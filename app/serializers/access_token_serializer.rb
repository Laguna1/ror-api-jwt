class AccessTokensSerializer
  include JSONAPI::Serializer
  attributes :id, :token
end
