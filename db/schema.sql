CREATE TABLE banks(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE
);

CREATE TABLE bank_accounts(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE
);

CREATE TABLE expense_categories(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE
);

CREATE TABLE transactions(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  bank_id INTEGER REFERENCES banks(id),
  bank_account_id INTEGER REFERENCES bank_accounts(id),
  expense_category_id INTEGER REFERENCES expense_categories(id),
  date_transacted TEXT,
  amount REAL,
  note TEXT
);
