class MiniResource

  def initialize(row, sheet)
    @row = row
	@sheet = sheet
	@idx_method = 1
    @idx_process = 2
    @idx_role = 3
    @idx_desc = 4
	@idx_islist = 5
	@idx_param = 6
	@idx_path = 7
	@idx_httpM = 8
  end

  def resource_method
	@row[@idx_method]
  end

  def resource_process
	@row[@idx_process]
  end

  def resource_role
    if @row[@idx_role] == nil or  @row[@idx_role] == ""
		nil
	else
		"\"" +  @row[@idx_role].split(",").join(",") + "\""
    end
  end

  def resource_desc
	@row[@idx_desc]
  end

  def resource_islist
	@row[@idx_islist] == "1"
  end

  def resource_param_type
	vals = []
    prms = @row[@idx_param].split(",")
    prms.map do |prm|
	  if prm.strip == "@query"
		vals.push("MiniQuery query")
	  elsif prm.strip == "@role"
		vals.push("OperatorRole role")
	  elsif prm.strip == "@obj"
	    vals.push("#{@sheet.model_name} obj")
	  else
		vals.push(prm)
	  end
    end
	vals.join(",")
  end

  def resource_param_value
    vals = []
    prms = @row[@idx_param].split(",")
    prms.map do |prm|
	  tmp = prm.split(" ")
	  vals.push(tmp[tmp.length - 1].gsub(/@/, ''))
    end
	if !@row[@idx_process].start_with?("super.")
		vals.push("this")
	end
	vals.join(",")
  end

  def resource_param_full
	vals = []
    prms = @row[@idx_param].split(",")
    prms.map do |prm|
	  if prm.strip == "@query"
		vals.push("MiniQuery query")
	  elsif prm.strip == "@role"
		vals.push("@Auth OperatorRole role")
	  elsif prm.strip == "@obj"
	    vals.push("#{@sheet.model_name} obj")
	  else
		arr = prm.split(" ")
		s = arr[arr.length - 1]
		if @row[@idx_path].include?("#{s}")
		  vals.push("@PathParam(\"#{s}\") #{prm.strip}")
		else
		  vals.push("@QueryParam(\"#{s}\") #{prm.strip}")
		end
	  end
    end
	vals.join(",")
  end

  def resource_path
	@row[@idx_path]
  end

  def resource_httpM
	@row[@idx_httpM]
  end

end