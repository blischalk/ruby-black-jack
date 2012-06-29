class DisplayParser
  def self.parse(p, n)
    case p
    when Dealer
      str = DealerDisplay.get_str(p, n)
    else
      str = get_str(p, n)
    end
  end

  def self.get_str(p, n)
    str = self.send_bust p, n
    if str == false
      begin
        if n == 'hand'
          str = p.send(n).hand
        else
          str = p.send(n.to_sym).to_s
        end
      rescue
        str = 'X'
      end
    end
    return str
  end

  def self.send_bust(p, n)
    status = check_status(p)
    if status == false and n != 'name' and n != 'pos'
      return str = 'Busted!'
    else
      return false
    end
  end

  def self.check_status(p)
    p.status != :loser || false
  end
end

class DealerDisplay < DisplayParser
  def get_str(p, n)
    str = send_bust(p, n)
    if str == false
      case n 
        when 'hand'
          str = p.send(n).hand_hidden
        when 'cash', 'bet'
          str = 'X'
        else
          str = p.send(n.to_sym).to_s
      end
    end
    return str
  end
end
