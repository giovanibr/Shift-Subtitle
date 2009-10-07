=begin
  Handles the time operations available by shift-subtitle script
=end
class SrtTime
  
  def initialize(time)
    v1 = time.split(':')
    v2 = v1[2].split(',')
    @hours = v1[0].strip.to_i
    @minutes = v1[1].strip.to_i
    @seconds = v2[0].strip.to_i
    @millis = v2[1].strip.to_i
  end
  
  # Redefine to_s to show time in srt format
  def to_s
    hours = @hours.to_s
    minutes = @minutes.to_s
    seconds = @seconds.to_s
    millis = @millis.to_s
    if @hours < 10
      hours = '0' + hours
    end
    if @minutes < 10
      minutes = '0' + minutes
    end
    if @seconds < 10
      seconds = '0' + seconds
    end
    if @millis < 10
      millis = '00' + millis
    else
      if @millis < 100
        millis = '0' + millis
      end
    end
    hours + ':' + minutes + ':' + seconds + ',' + millis
  end
  
  # add time
  def add(time)
    v = time.split(',')
    s = v[0].strip.to_i
    m = v[1].strip.to_i
    plus_millis(m)
    plus_seconds(s)
  end
  
  # subtract time
  def sub(time)
    v = time.split(',')
    s = v[0].strip.to_i
    m = v[1].strip.to_i
    sub_millis(m)
    sub_seconds(s)
  end
  
  def plus_millis(m)
    @millis = @millis + m
    if @millis > 999
      @millis = @millis % 1000
      @seconds += 1
    end
  end
  
  def plus_seconds(s)
    @seconds = @seconds + s
    if @seconds > 59
      @seconds = @seconds % 60
      @minutes += 1
    end
  end
  
  def sub_millis(m)
    @millis = @millis - m
    if @millis < 0
      @millis = 1000 + @millis
      @seconds -= 1
    end
  end
  
  def sub_seconds(s)
    @seconds = @seconds - s
    if @seconds < 0
      @seconds = 60 + @seconds
      @minutes -= 1
    end
  end
  
  private :plus_millis, :plus_seconds, :sub_millis, :sub_seconds
end