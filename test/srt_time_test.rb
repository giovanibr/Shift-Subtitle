require "test/unit"
require "lib/srt_time"


class SrtTimeTest < Test::Unit::TestCase
  
  def setup
    @t = SrtTime.new("01:01:01,111")
  end
  
  def test_to_s
    assert_equal("01:01:01,111", @t.to_s)
  end
  
  def test_add
    @t.add("11,111")
    assert_equal("01:01:12,222", @t.to_s)
    
    @t.add("00,778")
    assert_equal("01:01:13,000", @t.to_s)
    
    @t.add("47,000")
    assert_equal("01:02:00,000", @t.to_s)
  end
  
  def test_sub
    @t.sub("00,112")
    assert_equal("01:01:00,999", @t.to_s)
    
    @t.sub("01,000")
    assert_equal("01:00:59,999", @t.to_s)
  end
end