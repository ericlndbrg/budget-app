require 'csv'
require 'sqlite3'

bank_accounts = {
  'WF Checking' => 1,
  'WF Savings' => 2,
  'DCCU Checking' => 3,
  'DCCU Savings' => 4,
  'DCCU Money Market' => 5,
  'Cash' => 6,
  'DCCU Visa' => 7
}

expense_categories = {
  'AAB' => 1,
  'Amazon Prime' => 2,
  'Amex' => 3,
  'Bluehost' => 4,
  'Car Insurance' => 5,
  'Car Maintenance' => 6,
  'Cell Phone Service' => 7,
  'Charter' => 8,
  'Costco' => 9,
  'Double Edge' => 10,
  'Fitness' => 11,
  'Food' => 12,
  'FreeCodeCamp' => 13,
  'Gas' => 14,
  'Godaddy' => 15,
  'Healthcare' => 16,
  'Income' => 17,
  'Lastpass' => 18,
  'Life Lock' => 19,
  'Lynda' => 20,
  'Misc' => 21,
  'Movies' => 22,
  'Netflix' => 23,
  'NV Energy' => 24,
  'Rent' => 25,
  'Shopping' => 26,
  'TMWA' => 27,
  'Transfer' => 28,
  'TurboTax' => 29,
  'Uber' => 30,
  'Vacation' => 31,
  'Waste Management' => 32
}

begin

  db = SQLite3::Database.open 'prod.db'

  CSV.foreach(ARGF.argv[0], converters: :numeric, headers: true) do |row|
    sql = "INSERT INTO Transactions(transaction_date, transaction_amount, bank_account_id, expense_category_id, notes) VALUES(#{row['Date'].inspect}, #{row['Amount']}, #{bank_accounts[row['Account']]}, #{expense_categories[row['Category']]}, #{row['Notes'].inspect});"
    db.execute(sql)
  end

rescue SQLite3::Exception => e
  puts 'Exception Occured: '
  puts e
ensure
  db.close if db
end
