require File.join(File.dirname(__FILE__), 'tire_pressure')

describe Alarm do
  describe 'pressure_threshold' do
    it 'returns the low pressure threshold' do
      expect(Alarm::LOW_PRESSURE_THRESHOLD).to eq(17)
    end

    it 'returns the high pressure threshold' do
      expect(Alarm::HIGH_PRESSURE_THRESHOLD).to eq(21)
    end
  end

  describe 'test_alarm_off_by_default' do
    it 'should be off by default' do
      alarm = Alarm.new
      expect(alarm.is_alarm_on).to eq(false)
    end
  end

  describe '#check' do
    it 'update is_alarm_on to true if the pressure is too low' do
      alarm = Alarm.new

      alarm.check(16)

      expect(alarm.is_alarm_on).to eq(true)
    end

    it 'update is_alarm_on to true if the pressure is too high' do
      alarm = Alarm.new

      alarm.check(22)

      expect(alarm.is_alarm_on).to eq(true)
    end

    it 'alarm_on should remain false if the pressure is in acceptable range' do
      alarm = Alarm.new

      alarm.check(18)

      expect(alarm.is_alarm_on).to eq(false)
    end
  end
end
