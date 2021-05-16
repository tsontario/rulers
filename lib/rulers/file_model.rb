# frozen_string_literal: true
require "json"

module Rulers
  class FileModel
    def self.find(id)
      new("data/#{id}.json")
    rescue
      nil
    end

    def initialize(file)
      @file = file
      contents = File.read(file)
      @hash = JSON.parse(contents)
    end

    def [](field)
      @hash[field.to_s]
    end
  end
end
