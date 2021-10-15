class Score
  OPTIONS = %w[Love Fifteen Thirty Forty].freeze

  def self.call(point)
    OPTIONS[point]
  end
end

class TennisGame3
  def initialize(player1Name, player2Name)
    @p1N = player1Name
    @p2N = player2Name
    @p1 = 0
    @p2 = 0
  end

  def won_point(n)
    if n == @p1N
      @p1 += 1
    else
      @p2 += 1
    end
  end

  def score
    if game_still_in_progress?
      return "#{Score.call(@p1)}-All" if same_points?

      return "#{Score.call(@p1)}-#{Score.call(@p2)}"
    end

    return 'Deuce' if same_points?
    return "Advantage #{leading_player}" if points_diff_by_1?

    "Win for #{leading_player}"
  end

  private

  def game_still_in_progress?
    ((@p1 < 4) && (@p2 < 4)) && (@p1 + @p2 < 6)
  end

  def same_points?
    @p1 == @p2
  end

  def leading_player
    @p1 > @p2 ? @p1N : @p2N
  end

  def points_diff_by_1?
    (@p1 - @p2)**2 == 1
  end
end
