class Statistic
  include YamlFile

  attr_reader :statistic, :headings
  def initialize
    @headings = STAT_HEADER_LIST
    @statistic_items = []
  end

  def statistic_get
    statistic_load
    statistic_sort
    @statistic_items.each_with_index.map do |stat, index|
      [index.next, stat[:name], stat[:difficulty], stat[:attempts_total],
       stat[:attempts_used], stat[:hints_total], stat[:hints_used]]
    end
  end

  def statistic_add_item(name:, difficulty:, game_stage:)
    @statistic_items << { name: name,
                          difficulty: difficulty.name,
                          attempts_total: game_stage.attempts,
                          attempts_used: game_stage.step_number,
                          hints_total: difficulty.hints,
                          hints_used: game_stage.hint_used }
  end

  private

  def statistic_load
    @statistic_items = YamlFile.load(STAT_FILE_PATH)
  end

  def statistic_save
    YamlFile.save(STAT_FILE_PATH, @statistic_items)
  end

  def statistic_sort
    @statistic_items.sort_by! do |stat|
      [stat[:attempts_total] + stat[:hints_total],
       stat[:attempts_used], stat[:hints_used]]
    end
  end
end
