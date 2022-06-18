# budget-app
A small Ruby app that normalizes and saves personal finance data into a SQLite database.

A user-made CSV file contains the transaction data. This file is then imported into the app.

How to run the app
ruby app.rb <path_to_transaction_csv_file>

Example path_to_transaction_csv_file contents
bank,bank_account,expense_category,date_transacted,amount,note
wells fargo,checking,food,2022-06-15,-200,grocery
wells fargo,savings,income,2022-06-01,2000,paycheck
dccu,checking,rent,2022-06-01,1800,rent
