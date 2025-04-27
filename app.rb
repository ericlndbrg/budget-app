#!/usr/bin/env ruby

require 'csv'
require 'sqlite3'
require_relative 'classes/csv_normalizability_validator'
require_relative 'classes/csv_importer'

def execute
  csv_path, db_path = ARGF.argv
  CsvNormalizabilityValidator.new(csv_path, db_path).validate
  CsvImporter.new(csv_path, db_path).import
end

execute
