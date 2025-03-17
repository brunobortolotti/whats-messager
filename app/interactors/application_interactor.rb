# frozen_string_literal: true

class ApplicationInteractor
  attr_accessor :errors

  def self.call(...)
    instance = new(...)
    instance.execute
    instance
  end

  def initialize(*_args, **_kwargs)
    @errors = []
  end

  def success?
    @errors.empty?
  end

  def error?
    !success?
  end

  def add_error(message)
    @errors << message

    false
  end
end