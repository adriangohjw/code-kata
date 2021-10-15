class EqualScore
  OPTIONS = {
    0 => 'Love-All',
    1 => 'Fifteen-All',
    2 => 'Thirty-All'
  }.freeze

  def self.get(key)
    OPTIONS[key] || 'Deuce'
  end
end

class ScoreMoreThan4
  def self.get(p1_points, p2_points)
    case p1_points - p2_points
    when 1
      'Advantage player1'
    when -1
      'Advantage player2'
    when 2..Float::INFINITY
      'Win for player1'
    else
      'Win for player2'
    end
  end
end

class Score
  OPTIONS = {
    0 => 'Love',
    1 => 'Fifteen',
    2 => 'Thirty',
    3 => 'Forty'
  }

  def self.get(p1_points, p2_points)
    "#{OPTIONS[p1_points]}-#{OPTIONS[p2_points]}"
  end
end

class TennisGame1
  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @p1points = 0
    @p2points = 0
  end

  def won_point(player_name)
    if player_name == 'player1'
      @p1points += 1
    else
      @p2points += 1
    end
  end

  def score
    if @p1points == @p2points
      EqualScore.get(@p1points)
    elsif (@p1points >= 4) || (@p2points >= 4)
      ScoreMoreThan4.get(@p1points, @p2points)
    else
      Score.get(@p1points, @p2points)
    end
  end
end
