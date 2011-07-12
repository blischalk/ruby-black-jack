class Display
  def initialize(players)
    self.draw players
  end

  def draw(players)
    properties = %w{pos name hand cash bet}
    count = properties.count
    vals = {:lengths => {}, :totals => [], :count => count}
    # Iterate once to populate our hash
    properties.each do |n|
      vals[:lengths][n.to_sym] = get_len(players, n)
      arr = vals[:lengths][n.to_sym]
      vals[:totals] << arr.inject(0) { |sum, value| sum + value }
    end
    #iterate again to create the header row
    h_row = "|"
    compare_arr = []
    properties.each do |n|
      prop = 0
      max = vals[:lengths][n.to_sym].max
      h_len = n.to_s.length
      if h_len > max
        compare_arr << n.to_s
        max = h_len
      end
      l_margin = 1
      h_row += " " * l_margin
      h_row += "#{n}"
      r_margin = 1
      if not compare_arr.include? n.to_s
        r_margin = max - n.to_s.length + 1
      end
      h_row += " " * r_margin
      if prop < properties.count
        h_row += "|"
      end
      prop += 1
    end
    divider = "+" + "-" * (h_row.length - 2) + "+"
    puts divider
    puts h_row
    puts divider
    players.each do |p|
      p_row = "|"
      properties.each do |n|
        prop = 0
        begin
          if n == 'hand'
            str = p.send(:display_hand)
          else
            str = p.send(n.to_sym).to_s
          end
        rescue
          str = 'X'
        end
        spaces = 1
        max = vals[:lengths][n.to_sym].max
        h_len = n.to_s.length
        if h_len > max
          max = h_len
        end
        l_margin = 1
        p_row += " " * l_margin
        p_row += "#{str}"
        if compare_arr.include? n.to_s
          r_margin = (n.to_s.length - str.length) + 1
        else
          r_margin = (max - str.length) + 1
        end
        p_row += " " * r_margin
        if prop < properties.count
          p_row += "|"
        end
        prop += 1
      end
      puts p_row
    end
    puts divider
  end

  def get_len(players, property)
    arr = []
    players.each do |p|
      begin
        if property == 'hand'
          s = p.send(:display_hand)
          l = s.length
        else 
          l = p.send(property.to_sym).to_s.length
        end
        arr << l
      rescue
      end
    end
    return arr
  end

end
