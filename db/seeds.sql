INSERT INTO
  banks(name)
VALUES
  ('wells fargo'),
  ('dccu');

INSERT INTO
  bank_accounts(name)
VALUES
  ('checking'),
  ('savings');

INSERT INTO
  expense_categories(name)
VALUES
  ('food'),
  ('rent'),
  ('income');

INSERT INTO
  transactions(bank_id, bank_account_id, expense_category_id, date_transacted, amount, note)
VALUES
  (2, 1, 1, '2022-06-15', -150.00, 'grocery'),
  (2, 2, 2, '2022-06-30', -2000.00, ''),
  (1, 1, 3, '2022-06-20', 2000.00, 'paycheck');
