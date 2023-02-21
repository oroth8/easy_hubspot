# frozen_string_literal: true

module Helper
  def load_contact_json(file_name)
    File.open("#{File.dirname(__FILE__)}/fixtures/contact/#{file_name}.json").read
  end

  def load_deal_json(file_name)
    File.open("#{File.dirname(__FILE__)}/fixtures/deal/#{file_name}.json").read
  end
end
