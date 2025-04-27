class CsvImporter
  def initialize(csv_path, db_path)
    @csv_path = csv_path
    @db_path = db_path
  end

  def import
    @db = SQLite3::Database.new(db_path, results_as_hash: true)
    make_normalization_maps
    import_csv_data
    @db.close
  end

  private

  attr_reader :csv_path, :db_path

  def make_normalization_maps
    # sqlite query results look like this:
    #   [{"id"=>1, "name"=>"dccu"}, {"id"=>2, "name"=>"wells fargo"}]
    # I need to change them to look like this:
    #   { 'dccu' => 1, 'wells fargo' => 2 }
    @banks_map = make_map('banks')
    @bank_accounts_map = make_map('bank_accounts')
    @expense_categories_map = make_map('expense_categories')
  end

  def make_map(table_name)
    data_from_table = @db.execute("SELECT * FROM #{table_name}")
    data_from_table.each_with_object({}) do |results_hash, name_id_map|
      name_id_map[results_hash['name']] = results_hash['id']
    end
  end

  def import_csv_data
    CSV.foreach(csv_path, headers: true, converters: :numeric) do |row|
      normalized_transaction_data = [
        @banks_map[row['bank']],
        @bank_accounts_map[row['bank_account']],
        @expense_categories_map[row['expense_category']],
        row['date_transacted'],
        row['amount'],
        row['note']
      ]

      @db.execute(
        'INSERT INTO transactions(bank_id, bank_account_id, expense_category_id, date_transacted, amount, note) VALUES(?, ?, ?, ?, ?, ?)',
        normalized_transaction_data
      )
    end
  end
end
