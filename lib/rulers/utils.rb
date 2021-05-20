# frozen_string_literal: true
module Rulers
  module Utils
    extend(self)
    def to_underscore(s)
      s.gsub(/::/, "/")
      .gsub(
        /([A-Z]+)([A-Z][a-z])/,
        '\1_\2'
      ).gsub(
        /([a-z\d])([A-Z])/,
        '\1_\2'
      ).downcase
    end
  end
end
