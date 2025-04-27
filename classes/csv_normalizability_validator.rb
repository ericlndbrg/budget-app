class CsvNormalizabilityValidator
  def initialize(csv_path, db_path)
    @csv_path = csv_path
    @db_path = db_path
  end

  def validate
    @db = SQLite3::Database.new(db_path)
    collect_missing_parent_data
    persist_missing_parent_data
    @db.close
  end

  private

  attr_reader :csv_path, :db_path

  def collect_missing_parent_data
    # parent tables
    banks = []
    bank_accounts = []
    expense_categories = []

    # extract parent values from the CSV
    CSV.foreach(csv_path, headers: true) do |row|
      banks << row['bank']
      bank_accounts << row['bank_account']
      expense_categories << row['expense_category']
    end

    # collect parent values that don't show up in the database
    @missing_banks = collect_missing_data(banks.uniq, 'banks')
    @missing_bank_accounts = collect_missing_data(bank_accounts.uniq, 'bank_accounts')
    @missing_expense_categories = collect_missing_data(expense_categories.uniq, 'expense_categories')
  end

  def collect_missing_data(collection_from_csv, table_name)
    collection_from_csv.each_with_object([]) do |item_from_csv, missing_parent_values|
      query = @db.execute("SELECT * FROM #{table_name} WHERE name = ?", [item_from_csv])
      missing_parent_values << item_from_csv if query.empty?
    end
  end

  def persist_missing_parent_data
    # add any missing parent values to the database
    persist_missing_data(@missing_banks, 'banks') unless @missing_banks.empty?
    persist_missing_data(@missing_bank_accounts, 'bank_accounts') unless @missing_bank_accounts.empty?
    persist_missing_data(@missing_expense_categories, 'expense_categories') unless @missing_expense_categories.empty?
  end

  def persist_missing_data(missing_parent_values, table_name)
    missing_parent_values.each do |missing_parent_value|
      @db.execute("INSERT INTO #{table_name}(name) VALUES(?)", [missing_parent_value])
    end
  end
end
