CREATE TABLE banks(
  id INTEGER PRIMARY KEY NOT NULL,
  name TEXT UNIQUE
);

CREATE TABLE bank_accounts(
  id INTEGER PRIMARY KEY NOT NULL,
  name TEXT UNIQUE
);

CREATE TABLE expense_categories(
  id INTEGER PRIMARY KEY NOT NULL,
  name TEXT UNIQUE
);

CREATE TABLE transactions(
  id INTEGER PRIMARY KEY NOT NULL,
  bank_id INTEGER NOT NULL REFERENCES banks(id),
  bank_account_id INTEGER NOT NULL REFERENCES bank_accounts(id),
  expense_category_id INTEGER NOT NULL REFERENCES expense_categories(id),
  date_transacted TEXT,
  amount REAL,
  note TEXT
);
