module Pausable

  def rand_pause
    flex_pause(rand(20))
  end

  def flex_pause(seconds)
    start = Time.now.utc

    while true
      if Time.now.utc > start + seconds
        break
      end
    end

  end

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
