json.array!(@follows) do |follow|
  json.extract! follow, :follower_id, :followed_id
  json.url follow_url(follow, format: :json)
end
