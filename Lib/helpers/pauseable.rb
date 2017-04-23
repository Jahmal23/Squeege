module Pausable
  def brief_pause
    start = Time.now.utc

    while true
      if Time.now.utc > start + 8 # seconds
        break
      end
    end
  end


  def long_pause
    start = Time.now.utc

    while true
      if Time.now.utc > start + 12 # seconds
        break
      end
    end
  end

  def super_long_pause
    start = Time.now.utc

    while true
      if Time.now.utc > start + 30 # seconds
        break
      end
    end
  end

end
