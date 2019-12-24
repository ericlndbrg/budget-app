SELECT Transactions.id, transaction_date, transaction_amount, bank_account, expense_category, notes
FROM Transactions
INNER JOIN BankAccounts ON BankAccounts.id = Transactions.bank_account_id
INNER JOIN ExpenseCategories ON ExpenseCategories.id = Transactions.expense_category_id;
