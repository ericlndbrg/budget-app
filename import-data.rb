require 'csv'
require 'sqlite3'

begin

  db = SQLite3::Database.open 'transactions.db'
  db.execute('CREATE TABLE IF NOT EXISTS transactions(id INTEGER PRIMARY KEY, date TEXT, amount REAL, account TEXT, category TEXT, notes TEXT);')

  CSV.foreach(ARGF.argv[0], converters: :numeric, headers: true) do |row|
    sql = "INSERT INTO transactions(date, amount, account, category, notes) VALUES(#{row['date'].inspect}, #{row['amount'].inspect}, #{row['account'].inspect}, #{row['category'].inspect}, #{row['notes'].inspect});"
    db.execute(sql)
  end

rescue SQLite3::Exception => e
  puts 'Exception Occured: '
  puts e
ensure
  db.close if db
end
