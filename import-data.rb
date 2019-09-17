require 'csv'
require 'sqlite3'

begin

  db = SQLite3::Database.open 'transactions.db'
  db.execute('CREATE TABLE IF NOT EXISTS transactions(id INTEGER PRIMARY KEY, date TEXT, amount REAL, account TEXT, category TEXT, notes TEXT);')

  transaxns = CSV.read('transactions.csv', converters: :numeric)

  transaxns.each do |row|
    sql = "INSERT INTO transactions(date, amount, account, category, notes) VALUES(#{row});"
    sql_without_brackets = sql.gsub(/VALUES\(\[/, 'VALUES(').gsub(/\]\);/, ');')
    db.execute(sql_without_brackets)
  end

rescue SQLite3::Exception => e
  puts 'Exception Occured: '
  puts e
ensure
  db.close if db
end
