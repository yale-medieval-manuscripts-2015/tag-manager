json.array!(@tags) do |tag|
  json.extract! tag, :id, :tag, :label, :category
  json.url tag_url(tag, format: :json)
end
