module Helper
  def load_json(file_name)
    File.open("#{File.dirname(__FILE__)}/fixtures/#{file_name}.json").read
  end
end
