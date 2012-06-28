class Display
  attr_accessor :players
  def initialize(players)
    @players = players
  end

  def draw
    #create an array of player properties
    properties = %w{pos name hand cash bet}
    count = properties.count
    #create a hash of information used in displaying data
    vals = {:lengths => {}, :totals => [], :count => count}
    # Iterate once to populate our hash
    properties.each do |n|
      vals[:lengths][n.to_sym] = get_len(n)
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
    @players.each do |p|
      p_row = "|"
      properties.each do |n|
        prop = 0
        
        str = DisplayParser.parse(p, n)
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

  

  #possible case for polymorphism
  def get_len(prop)
    arr = []
    @players.each do |p|
      if p.status != false
        if prop == 'hand'
          s = p.send(prop).hand
          l = s.length
        else 
          begin
            l = p.send(prop.to_sym).to_s.length
          rescue
            l = 'X'.length
          end
        end
      else
        if prop =='name'
          l = p.send(prop.to_sym).to_s.length
        else
          l = 'Busted'.length
        end
      end
      arr << l
    end
    return arr
  end

end
