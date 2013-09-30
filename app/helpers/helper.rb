

helpers do

  def stale?(timestamp)
    time_elapsed = Time.now - timestamp
    if time_elapsed > 5000
      return true  
    else 
      return false 
    end
  end 


end
