module SmartFilter
  def smart_filter(options)
    @conds = []
    columns.each do |column|
      if options[column.name.to_sym]
        case options[column.name.to_sym].keys.first
        when "contains"         then @conds << contains(column.name, options[column.name.to_sym]["contains"])
        when "does_not_contain" then @conds << does_not_contain(column.name, options[column.name.to_sym]["does_not_contain"])
        when "is"               then @conds << is(column.name, options[column.name.to_sym]["is"])
        when "starts_with"      then @conds << starts_with(column.name, options[column.name.to_sym]["starts_with"])
        when "ends_with"        then @conds << ends_with(column.name, options[column.name.to_sym]["ends_with"])
        when "equals_to"        then @conds << equals_to(column.name, options[column.name.to_sym]["equals_to"])
        when "greater_than"     then @conds << greater_than(column.name, options[column.name.to_sym]["greater_than"])
        when "less_than"        then @conds << less_than(column.name, options[column.name.to_sym]["less_than"])
        when "between"          then @conds << between(column.name, 
                                                      options[column.name.to_sym]["between"].first, 
                                                      options[column.name.to_sym]["between"].last)
        else
          return []
        end
      end
    end
    return find(:all, 
                :conditions => conditions(@conds))
  end

  private

  def conditions(conds)
    conds.flatten!
    @final = []
    @terms = []
    conds.each_with_index do |condition, index|
      if (index + 1) % 2 == 0
        if condition.is_a?(Hash)
          @terms << condition.to_a.flatten
        else
          @terms << condition
        end
      elsif (index + 1) % 2 != 0
        @final << condition
      end
    end
    return [@final.join(' AND '), @terms].flatten
  end

  def contains(column, term)
    ["#{column} LIKE ?", "%#{term}%"]
  end

  def does_not_contain(column, term)
    ["#{column} NOT LIKE ?", "%#{term}%"]
  end

  def between(column, start, finish)
    ["#{column} BETWEEN ? AND ?", {start => finish}]
  end

  def is(column, term)
    ["#{column} = ?", term]
  end

  def starts_with(column, term)
    ["#{column} LIKE ?", "#{term}%"]
  end

  def ends_with(column, term)
    ["#{column} LIKE ?", "%#{term}"]
  end

  alias :equals_to :is

  def greater_than(column, term)
    ["#{column} > ?", term]
  end

  def less_than(column, term)
    ["#{column} < ?", term]
  end
end