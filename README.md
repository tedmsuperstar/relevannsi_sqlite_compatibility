# Relevannsi SQLite Compatibility
Relevannsi search plugin compatibility with Wordpress on SQLite. Relevannsi is a popular, powerful Wordpress plugin. The SQL contained in the plugin is intended to run on MySQL or similar database, and uses some features not available on SQLite.

## Summary
1. Given that you have Wordpress running on SQLite, and want to use the Relevannsi plugin for search...
2. Add the code in filters.php to your theme's functions.php file. 
3. Install the Relevannsi plugin. The tables will fail to create due to incompatibilities with the SQL the plugin usues to initialize itself.
4. Run the SQL statements in create_relevannsi_tables.sql
5. You should now be able to run indexing and make queries.




## SQLite Conversion for Relevanssi Plugin
### Overview
This project contains SQL scripts that convert the default MySQL queries for the Relevanssi plugin into SQLite-compatible queries. Relevanssi is a powerful search plugin for WordPress, but it was initially designed to work with MySQL databases. In this conversion, we’ve adapted the SQL commands for compatibility with SQLite, which is being used as the database for this WordPress setup.
The following instructions will guide you on how to run the scripts to set up your SQLite database and ensure compatibility with Relevanssi’s table structures and indexing requirements.

### Prerequisites
SQLite Database: You must have an SQLite database set up for your WordPress site. If you're using WordPress Studio with SQLite, ensure that the SQLite integration is properly configured.
SQLite Client: You’ll need an SQLite client to run these SQL scripts. Some popular tools include:
DB Browser for SQLite
Command-line tool sqlite3
Relevanssi Plugin: Make sure that the Relevanssi plugin is installed and activated in your WordPress installation.

### Running the Scripts
1. Backup Your Database
Before applying these changes, it is highly recommended to backup your SQLite database. This ensures that you can restore your original database if anything goes wrong.
2. Open Your SQLite Database
Use your preferred SQLite client to open the WordPress SQLite database.
If you're using the command line, navigate to the directory containing your SQLite database file and enter:
bash
Copy code
sqlite3 database.sqlite
(Replace database.sqlite with your actual database filename.)
3. Execute the SQL Scripts
You can either paste the SQL commands directly into the SQLite client, or save the commands into a .sql file and run them as a batch.
For example, if your commands are saved in relevanssi_conversion.sql, you can run:
bash
Copy code
sqlite3 database.sqlite < relevanssi_conversion.sql


### Explanation of Queries
#### Table Creation
The following queries create the necessary tables for Relevanssi in the SQLite database:
wp_relevanssi
This table holds the indexed search terms and associated data.
sql
Copy code
CREATE TABLE wp_relevanssi (
    doc INTEGER NOT NULL DEFAULT 0,
    term TEXT NOT NULL DEFAULT '0',
    term_reverse TEXT NOT NULL DEFAULT '0',
    content INTEGER NOT NULL DEFAULT 0,
    title INTEGER NOT NULL DEFAULT 0,
    comment INTEGER NOT NULL DEFAULT 0,
    tag INTEGER NOT NULL DEFAULT 0,
    link INTEGER NOT NULL DEFAULT 0,
    author INTEGER NOT NULL DEFAULT 0,
    category INTEGER NOT NULL DEFAULT 0,
    excerpt INTEGER NOT NULL DEFAULT 0,
    taxonomy INTEGER NOT NULL DEFAULT 0,
    customfield INTEGER NOT NULL DEFAULT 0,
    mysqlcolumn INTEGER NOT NULL DEFAULT 0,
    taxonomy_detail TEXT NOT NULL,
    customfield_detail TEXT NOT NULL DEFAULT '',
    mysqlcolumn_detail TEXT NOT NULL DEFAULT '',
    type TEXT NOT NULL DEFAULT 'post',
    item INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (doc, term, item)
);


wp_relevanssi_stopwords
This table stores stopwords (common words ignored in searches).
sql
Copy code
CREATE TABLE wp_relevanssi_stopwords (
    stopword TEXT NOT NULL,
    PRIMARY KEY (stopword)
);


wp_relevanssi_log
This table logs search queries, hits, and related data.
sql
Copy code
CREATE TABLE wp_relevanssi_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    query TEXT NOT NULL,
    hits INTEGER NOT NULL DEFAULT 0,
    time TEXT DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL DEFAULT 0,
    ip TEXT NOT NULL DEFAULT '',
    session_id TEXT NOT NULL DEFAULT ''
);


#### Index Creation
The following index queries improve the speed of searching and querying the data:
Index on wp_relevanssi by term
This index speeds up searches based on the term column.
sql
Copy code
CREATE INDEX terms ON wp_relevanssi (term);

Index on wp_relevanssi by relevanssi_term_reverse_idx
CREATE INDEX relevanssi_term_reverse_idx ON wp_relevanssi (term_reverse);


Index on wp_relevanssi_log by session_id
This index improves performance when querying logs by session.
sql
Copy code
CREATE INDEX session_id ON wp_relevanssi_log (session_id);


Composite Index on wp_relevanssi_log by type and item
This index speeds up queries by both type and item.
sql
Copy code
CREATE INDEX typeitem ON wp_relevanssi_log (type, item);


CREATE INDEX query ON wp_relevanssi_log (query)



### Notes
MySQL-Specific Syntax Adjustments:
The original MySQL queries contained data type specifications like bigint(20), varchar(50), and mediumint(9), which were replaced with SQLite-compatible types like INTEGER and TEXT.
Character Set:
The CHARACTER SET utf8mb4 clauses were removed since SQLite uses UTF-8 by default.
Auto-Increment:
The AUTO_INCREMENT keyword in MySQL was replaced with INTEGER PRIMARY KEY AUTOINCREMENT in SQLite.
Triggers for Updates:
SQLite does not support ON UPDATE CURRENT_TIMESTAMP. If you need this functionality, you will have to manage it via a trigger or in your application code.

### Troubleshooting
If you encounter any errors while running these scripts, check the following:
Ensure the table does not exist already:
If the table wp_relevanssi or other Relevanssi tables already exist in your SQLite database, you'll need to drop the existing tables before running the new CREATE TABLE commands:
sql
Copy code
DROP TABLE IF EXISTS wp_relevanssi;


### Database Integrity:
Ensure that there are no conflicting column types or data issues in your SQLite database.

####Conclusion
You’ve now successfully converted and set up the necessary tables and indexes for the Relevanssi plugin to work with SQLite. By following the above steps and executing the provided SQL queries, your WordPress site should be ready to use Relevanssi with SQLite as its database.
If you run into any issues, feel free to reach out for further assistance!





