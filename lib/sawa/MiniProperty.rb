class MiniProperty
  def initialize(row, sheet)
    @row = row
    @sheet = sheet
    @idx_type = 1
    @idx_name = 2
    @idx_unique = 3
    @idx_nullable = 4
    @idx_jsonignore = 5
    @idx_title = 6
    @idx_mappedBy = 7
    @idx_refColumn = 8
    @idx_searchKey = 9
  end

  def resource_name
    @sheet.resource_path
  end

  def name
    @row[@idx_name]
  end

  def type
    @row[@idx_type]
  end

  def type_js
    if @row[@idx_type] == "java.lang.String"
      return "txt"
    end
    if @row[@idx_type] == "java.lang.Integer" or @row[@idx_type] == "java.lang.Short" or @row[@idx_type] == "java.lang.Long" or @row[@idx_type] == "java.lang.Float" or @row[@idx_type] == "java.lang.Double"
      return "num"
    end
    if @row[@idx_type].start_with?("java.util.List")
      return "list"
    end
    return "obj"
  end

  def unique
    @row[@idx_unique] == "1"
  end

  def nullable
    @row[@idx_nullable] == "1"
  end

  def jsonignore
    @row[@idx_jsonignore] == "1"
  end

  def title
    @row[@idx_title]
  end

  def is_column
    @row[@idx_unique] != "-"
  end

  def has_mapped
    @row[@idx_mappedBy] == "1:1" or @row[@idx_mappedBy] == "1:n" or @row[@idx_mappedBy] == "n:1"
  end

  def join_column
    @row[@idx_refColumn]
  end

  def is_onetomany
    @row[@idx_mappedBy] == "1:n"
  end

  def is_manytoone
    @row[@idx_mappedBy] == "n:1"
  end

  def is_onetoone
    @row[@idx_mappedBy] == "1:1"
  end
  
  def is_searchkey
    @row[@idx_searchKey] == "1"
  end
end