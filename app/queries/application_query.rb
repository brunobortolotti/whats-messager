# frozen_string_literal: true

class ApplicationQuery
  def self.call(...)
    instance = new(...)
    instance.query
  end

  def initialize(...); end
end