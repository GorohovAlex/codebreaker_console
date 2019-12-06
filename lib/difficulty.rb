class Difficulty
  attr_reader :name, :attempts, :hints

  def initialize(name:, attempts:, hints:, level:)
    @name = name
    @attempts = attempts
    @hints = hints
    @level = level
  end
end
