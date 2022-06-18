#!/usr/bin/env ruby

require 'csv'
require 'sqlite3'

def get_id(records, search_term)
  records.each do |record|
    return record['id'] if record['name'].eql?(search_term)
    next
  end
end

def main
  db = SQLite3::Database.new('db/dev.db', results_as_hash: true)

  banks = db.execute('SELECT * FROM banks')
  bank_accounts = db.execute('SELECT * FROM bank_accounts')
  expense_categories = db.execute('SELECT * FROM expense_categories')

  CSV.foreach(ARGF.argv[0], headers: true, converters: :float) do |row|
    normalized_row_data = [get_id(banks, row['bank']), get_id(bank_accounts, row['bank_account']), get_id(expense_categories, row['expense_category']), row['date_transacted'], row['amount'], row['note']]
    db.execute('INSERT INTO transactions(bank_id, bank_account_id, expense_category_id, date_transacted, amount, note) VALUES(?, ?, ?, ?, ?, ?)', normalized_row_data)
  end

  db.close
end

main
