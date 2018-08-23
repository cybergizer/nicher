module ResponseParser
  def response_to_json
    JSON.parse(@response.body)
  end
end
