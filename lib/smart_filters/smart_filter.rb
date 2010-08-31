module SmartFilter

  def smart_filter(options)
    columns.each do |column|
      @conds = generate_sql(column, options[column.name.to_sym]) if options[column.name.to_sym]
    end

    @conds.empty? ? (return []) : (return find(:all, :conditions => conditions(@conds)))
  end

  private

  def generate_sql(column, criteria)
    conditions = []

    case criteria.keys.first
    when "contains"         then conditions << contains(column.name, criteria["contains"])
    when "does_not_contain" then conditions << does_not_contain(column.name, criteria["does_not_contain"])
    when "is"               then conditions << is(column.name, criteria["is"])
    when "starts_with"      then conditions << starts_with(column.name, criteria["starts_with"])
    when "ends_with"        then conditions << ends_with(column.name, criteria["ends_with"])
    when "equals_to"        then conditions << equals_to(column.name, criteria["equals_to"])
    when "greater_than"     then conditions << greater_than(column.name, criteria["greater_than"])
    when "less_than"        then conditions << less_than(column.name, criteria["less_than"])
    when "between"          then conditions << between(column.name, 
                                                  criteria["between"].first, 
                                                  criteria["between"].last)
    when "on"               then conditions << on(column.name, criteria["on"])
    when "before"           then conditions << before(column.name, criteria["before"])
    when "after"            then conditions << after(column.name, criteria["after"])
    end

    return conditions
  end

  def conditions(conds)
    @final, @terms = [], []

    conds.flatten!.each_with_index do |condition, index|
      index.odd? ? @terms << condition.to_a.flatten : @final << condition
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

  def on(column, term)
    ["#{column} LIKE ?", "#{term}%"]
  end

  def before(column, term)
    ["#{column} < ?", "#{term}"]
  end

  def after(column, term)
    ["#{column} > ?", "#{term}"]
  end
end