module Pausable
  def brief_pause
    start = Time.now.utc

    while true
      if Time.now.utc > start + 8 # seconds
        break
      end
    end
  end
end
