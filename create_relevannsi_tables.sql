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

CREATE INDEX terms ON wp_relevanssi (term);


CREATE INDEX relevanssi_term_reverse_idx ON wp_relevanssi (term_reverse);

CREATE INDEX typeitem ON wp_relevanssi (type, item);

CREATE TABLE wp_relevanssi_stopwords (
        stopword TEXT NOT NULL,
        PRIMARY KEY (stopword)
    );

CREATE TABLE wp_relevanssi_log (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        query TEXT NOT NULL,
        hits INTEGER NOT NULL DEFAULT 0,
        time TEXT DEFAULT CURRENT_TIMESTAMP,
        user_id INTEGER NOT NULL DEFAULT 0,
        ip TEXT NOT NULL DEFAULT '',
        session_id TEXT NOT NULL DEFAULT ''
    );

CREATE INDEX query ON wp_relevanssi_log (query);

CREATE INDEX session_id ON wp_relevanssi_log (session_id);