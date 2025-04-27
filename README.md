# budget-app
A small Ruby app that normalizes and saves personal finance data into a SQLite database.

## How to use the app
Create the database
```
$ cd db
$ sqlite3 database_name.db
```

Enable FK support
```
sqlite> PRAGMA foreign_keys = ON;
```

Import the schema
```
sqlite> .read schema.sql
```

Run the app
```
$ ruby app.rb path/to/csv.csv path/to/database_name.db
```
