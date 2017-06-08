# coding: UTF-8
require 'spreadsheet'
require 'mustache'
require 'sawa/MiniSheet.rb'

class MiniWork < Mustache

  def initialize(file, config)
    @book = Spreadsheet.open(file, 'r')
	@sheets = Hash.new()
	@book.worksheets.each do |sheet|
		@sheets[sheet.name] = MiniSheet.new(sheet, config)
	end
  end

  def sheets
	@sheets
  end

  def sheet_arr
    arr = []
	@sheets.each do |name, sheet|
		arr.push(sheet)
	end
	arr
  end

  def sheet(name)
	@sheets[name]
  end

end