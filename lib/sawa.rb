require 'fileutils'
require 'sawa/MiniWork.rb'
require 'yaml'

class Sawa
  ROOT = Dir.pwd
  GEMROOT = File.dirname(File.expand_path(__FILE__))
  def initialize(options)
  	puts options
    @config = YAML.load_file("#{ROOT}/#{options[1]}")
    @work = MiniWork.new(options[0], @config)
    @JSRC_PATH = "#{ROOT}/www/src"
    @XML_PATH = "#{ROOT}/resources"
    @MODEL_PATH = "#{ROOT}/src/" + @config['packageModel'].split('.').join("/")
    @DAO_PATH = "#{ROOT}/src/" + @config['packageDao'].split('.').join("/")
    @RES_PATH = "#{ROOT}/src/" + @config['packageResource'].split('.').join("/")
    @API_PATH = "#{ROOT}/src/" + @config['packageApi'].split('.').join("/")
    @TPL_PATH = "#{GEMROOT}/sawa/tpl"
  end

  def generate_code
    #mkdir
    FileUtils.mkdir_p @MODEL_PATH
    FileUtils.mkdir_p @DAO_PATH
    FileUtils.mkdir_p @RES_PATH
    FileUtils.mkdir_p @API_PATH

    #create_model
    @work.sheets.each do |name, sheet|
      sheet.template_file = "#{@TPL_PATH}/model.mustache"
      str_model = sheet.render
      File.open("#{@MODEL_PATH}/#{sheet.model_name}.java", 'w') { |file| file.write(str_model) }
    end

    #create_dao
    @work.sheets.each do |name, sheet|
      sheet.template_file = "#{@TPL_PATH}/dao.mustache"
      str_dao = sheet.render
      File.open("#{@DAO_PATH}/#{sheet.dao_name}.java", 'w') { |file| file.write(str_dao) }
    end

    #create_resource
    @work.sheets.each do |name, sheet|
      sheet.template_file = "#{@TPL_PATH}/resource.mustache"
      str_resource = sheet.render
      File.open("#{@RES_PATH}/#{sheet.resource_name}.java", 'w') { |file| file.write(str_resource) }
    end

    #create_api
    @work.sheets.each do |name, sheet|
      sheet.template_file = "#{@TPL_PATH}/api.mustache"
      str_api = sheet.render
      File.open("#{@API_PATH}/#{sheet.api_name}.java", 'w') { |file| file.write(str_api) }
    end

    #crud.xml
    @work.template_file = "#{@TPL_PATH}/crud.mustache"
    str_crud = @work.render
    File.open("#{@XML_PATH}/crud.xml", 'w') { |file| file.write(str_crud) }

    #property.properties
    @work.template_file = "#{@TPL_PATH}/property.mustache"
    str_property = @work.render
    File.open("#{@XML_PATH}/property.properties", 'w') { |file| file.write(str_property) }

    #Routes.js
    @work.template_file = "#{@TPL_PATH}/routes.js.mustache"
    str_routes_js = @work.render
    File.open("#{@JSRC_PATH}/Routes.js", 'w') { |file| file.write(str_routes_js) }
      
    #Toolbar.js
    @work.template_file = "#{@TPL_PATH}/toolbar.js.mustache"
    str_toolbar_js = @work.render
    File.open("#{@JSRC_PATH}/Toolbar.js", 'w') { |file| file.write(str_toolbar_js) }

    #Source.js
    @work.template_file = "#{@TPL_PATH}/source.js.mustache"
    str_source_js = @work.render
    File.open("#{@JSRC_PATH}/Source.js", 'w') { |file| file.write(str_source_js) }

    #pages
    @work.sheets.each do |name, sheet|
      sheet.template_file = "#{@TPL_PATH}/page.js.mustache"
      str_page_js = sheet.render
      File.open("#{@JSRC_PATH}/pages/#{sheet.page_name}.js", 'w') { |file| file.write(str_page_js) }
    end

    "code generate finish"
  end
  # Your code goes here...
end
