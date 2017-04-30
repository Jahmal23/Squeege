module Pausable
  def brief_pause
    start = Time.now.utc

    while true
      if Time.now.utc > start + 10 # seconds
        break
      end
    end
  end


  def long_pause
    start = Time.now.utc

    while true
      if Time.now.utc > start + 15 # seconds
        break
      end
    end
  end

  def super_long_pause
    start = Time.now.utc

    while true
      if Time.now.utc > start + 60 # seconds
        break
      end
    end
  end

end
