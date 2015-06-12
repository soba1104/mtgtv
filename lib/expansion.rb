class Expansion
  attr_reader :name

  public

  def self.load(name)
    self.new(name)
  end

  private

  def initialize(name)
    @name = name
  end
end
