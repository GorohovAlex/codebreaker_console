class Difficulty
  attr_reader :name, :attempts, :hints

  def initialize(name:, attempts: 25, hints:, level:)
    @name = name
    @attempts = attempts
    @hints = hints
    @level = level
  end
end
