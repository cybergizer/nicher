module OmniauthMacros
  def mock_auth
    @mock_hash ||= json_responses.inject({}) do |sum, (filename, content)|
      sum[filename] = to_recursive_ostruct(content)
      sum
    end
  end

  def to_recursive_ostruct(hash)
    OpenStruct.new(hash.each_with_object({}) do |(key, val), memo|
      memo[key] = val.is_a?(Hash) ? to_recursive_ostruct(val) : val
    end)
  end

  def json_responses
    @json_responses ||= FileReader.new(OAUTH_RESPONSES_PATH).files_hash
  end
end
