def sort_smart_filter
  if params[:smart_filter]
    search = params[:smart_filter]
    hash = {}
    search.delete_if {|column, value| value[:value] == "" }
    search.each do |column, value|
      hash.merge!({column.to_sym => {value[:criteria] => value[:value]}})
    end
    @filtered_results = params[:smart_filter][:model].constantize.smart_filter(hash)
  end
end
