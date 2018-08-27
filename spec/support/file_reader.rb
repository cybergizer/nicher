class FileReader
  def initialize(path)
    @responses_path = path
  end

  def files_hash
    file_list.inject({}) do |sum, file_name|
     file_path = OAUTH_RESPONSES_PATH + file_name
     file_name = File.basename(file_path, '.json')
     sum[file_name.to_sym] = JSON.parse(File.read(file_path))
     sum 
   end
  end

  private
  def file_list
    Dir.entries(@responses_path).reject { |file_name| File.directory?(file_name) }
  end
end
