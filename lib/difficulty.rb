class Difficulty
  attr_reader :name, :attempts, :hints

  def initialize(name:, attempts: 25, hints:)
    @name = name
    @attempts = attempts
    @hints = hints
  end
end
