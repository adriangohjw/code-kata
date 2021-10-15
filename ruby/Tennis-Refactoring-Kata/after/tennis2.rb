class Score
  OPTIONS = {
    0 => 'Love',
    1 => 'Fifteen',
    2 => 'Thirty',
    3 => 'Forty'
  }

  def self.call(point)
    OPTIONS[point]
  end
end

class TennisGame2
  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @p1points = 0
    @p2points = 0
  end

  def won_point(player_name)
    if player_name == @player1_name
      @p1points += 1
    else
      @p2points += 1
    end
  end

  def score
    return "Win for #{@player2_name}" if player_2_win?
    return "Win for #{@player1_name}" if player_1_win?
    return "Advantage #{@player2_name}" if advantage_player_2?
    return "Advantage #{@player1_name}" if advantage_player_1?
    return "#{Score.call(@p1points)}-#{Score.call(@p2points)}" if diff_score_and_game_in_progress?
    return "#{Score.call(@p2points)}-Love" if player_2_score_and_player_1_zero?
    return "#{Score.call(@p1points)}-Love" if player_1_score_and_player_2_zero?
    return unless same_points?

    @p1points > 2 ? 'Deuce' : "#{Score.call(@p1points)}-All"
  end

  private

  def player_2_win?
    (@p2points >= 4) && (@p1points >= 0) && ((@p2points - @p1points) >= 2)
  end

  def player_1_win?
    (@p1points >= 4) && (@p2points >= 0) && ((@p1points - @p2points) >= 2)
  end

  def advantage_player_2?
    (@p2points > @p1points) && (@p1points >= 3)
  end

  def advantage_player_1?
    (@p1points > @p2points) && (@p2points >= 3)
  end

  def diff_score_and_game_in_progress?
    (@p2points > @p1points) && (@p2points < 4) ||
      (@p1points > @p2points) && (@p1points < 4)
  end

  def player_2_score_and_player_1_zero?
    @p2points.positive? && @p1points.zero?
  end

  def player_1_score_and_player_2_zero?
    @p1points.positive? && @p2points.zero?
  end

  def same_points?
    @p1points == @p2points
  end
end
