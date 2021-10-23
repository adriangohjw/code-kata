class Sensor
  OFFSET = 16

  def pop_next_pressure_psi_value
    Sensor.OFFSET + sample_pressure
  end

  def self.sample_pressure
    # placeholder implementation that simulate a real sensor in a real tire
    6 * rand * rand
  end
end

class Alarm
  LOW_PRESSURE_THRESHOLD = 17
  HIGH_PRESSURE_THRESHOLD = 21

  attr_reader :is_alarm_on

  def initialize
    @low_pressure_threshold = LOW_PRESSURE_THRESHOLD
    @high_pressure_threshold = HIGH_PRESSURE_THRESHOLD
    @is_alarm_on = false
  end

  def check(psi_pressure_value = Sensor.new.pop_next_pressure_psi_value)
    return unless (psi_pressure_value < @low_pressure_threshold) || (@high_pressure_threshold < psi_pressure_value)

    @is_alarm_on = true
  end
end
