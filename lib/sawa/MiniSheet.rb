require 'mustache'
require 'spreadsheet'
require 'sawa/MiniProperty.rb'
require 'sawa/MiniResource.rb'

class MiniSheet < Mustache
  def initialize(sheet, config)
    @sheet = sheet
    @config = config
    @idx_path = 2
    @idx_title = 3
    @idx_method = 1
    @idx_process = 2
    @idx_role = 3
    @idx_type = 1
    @idx_name = 2
    @idx_unique = 3
    @idx_nullable = 4
    @idx_jsonignore = 5
    @idx_mtitle = 6
    @idx_mappedBy = 7
    @idx_refColumn = 8
    @idx_isList = 5
    @idx_param = 6
  end

  def name
    @sheet.name
  end

  def rows_model
    get_model_rows(@sheet)
  end

  def rows_path
    get_path_rows(@sheet)
  end

  def package_api
    @config['packageApi']
  end

  def package_dao
    @config['packageDao']
  end

  def package_model
    @config['packageModel']
  end

  def package_resource
    @config['packageResource']
  end

  def table_name
    @sheet.name
  end

  def model_name
    getName("model", @sheet.name)
  end

  def resource_path
    @sheet.row(0)[@idx_path]
  end

  def model_title
    @sheet.row(0)[@idx_title]
  end

  def dao_name
    getName("dao", @sheet.name)
  end

  def resource_name
    getName("resource", @sheet.name)
  end

  def page_name
    getName("page", @sheet.name)
  end

  def api_name
    getName("if", @sheet.name)
  end

  def model_property_metas
    arr = []
    @sheet.each do |row|
      if row[0] == "m" and row[@idx_jsonignore] == "1"
        arr.push "#{@sheet.row(0)[@idx_path]}.#{row[@idx_name]}=#{row[@idx_type]},#{row[@idx_nullable]},#{row[@idx_mtitle]}"
      end
    end
    arr
  end

  def model_imports
    arr = []
    @sheet.each do |row|
      if row[0] != "m"
        next
      end

      if row[@idx_jsonignore] == "1" and !arr.include?("import com.fasterxml.jackson.annotation.JsonIgnore;")
        arr.push "import com.fasterxml.jackson.annotation.JsonIgnore;"
      end
      if row[@idx_mappedBy] == "1:n" and !arr.include?("import javax.persistence.OneToMany;")
        arr.push "import javax.persistence.OneToMany;"
      end
      if row[@idx_mappedBy] == "1:n" and !arr.include?("import com.fasterxml.jackson.annotation.JsonManagedReference;")
        arr.push "import com.fasterxml.jackson.annotation.JsonManagedReference;"
      end
      if row[@idx_mappedBy] == "1:n" and !arr.include?("import org.hibernate.annotations.Where;")
        arr.push "import org.hibernate.annotations.Where;"
      end

      if row[@idx_mappedBy] == "n:1" and !arr.include?("import javax.persistence.ManyToOne;")
        arr.push "import javax.persistence.ManyToOne;"
      end
      if row[@idx_mappedBy] == "n:1" and !arr.include?("import com.fasterxml.jackson.annotation.JsonBackReference;")
        arr.push "import com.fasterxml.jackson.annotation.JsonBackReference;"
      end
      if row[@idx_mappedBy] == "n:1" and !arr.include?("import javax.persistence.JoinColumn;")
        arr.push "import javax.persistence.JoinColumn;"
      end

      if row[@idx_mappedBy] == "1:1" and !arr.include?("import javax.persistence.OneToOne;")
        arr.push "import javax.persistence.OneToOne;"
      end
      if row[@idx_mappedBy] == "1:1" and !arr.include?("import javax.persistence.JoinColumn;")
        arr.push "import javax.persistence.JoinColumn;"
      end
    end
    arr
  end

  def resource_imports
    arr = []
    @sheet.each do |row|
      if row[0] != "p"
        next
      end
      if row[@idx_jsonignore] == "1" and !arr.include?("import java.util.List;")
        arr.push "import java.util.List;"
      end
    end
    arr
  end

  def api_imports
    arr = []
    @sheet.each do |row|
      if row[0] != "p"
        next
      end
      if row[@idx_isList] == "1" and !arr.include?("import java.util.List;")
        arr.push "import java.util.List;"
      end
      if row[@idx_param].include?("@role") and !arr.include?("import io.dropwizard.auth.Auth;")
        arr.push "import io.dropwizard.auth.Auth;"
      end
    end
    arr
  end

  private

  def getName(type, sheetName)
    perfix = sheetName.split("_")
    perfix[0].capitalize + perfix[1].capitalize + type.capitalize
  end

  private

  def get_model_rows(sheet)
    rows_model = []
    sheet.each do |row|
      if row[0] == "m"
        rows_model.push(MiniProperty.new(row, self))
      end
    end
    rows_model
  end

  private

  def get_path_rows(sheet)
    rows_path = []
    sheet.each do |row|
      if row[0] == "p"
        rows_path.push(MiniResource.new(row, self))
      end
    end
    rows_path
  end
end