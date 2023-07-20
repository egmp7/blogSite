
-- This makes sure that foreign_key constraints are observed and that errors will be thrown for violations
PRAGMA foreign_keys=ON;

BEGIN TRANSACTION;

--create your tables with SQL commands here (watch out for slight syntactical differences with SQLite)

CREATE TABLE IF NOT EXISTS testUsers (
    test_user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    test_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS testUserRecords (
    test_record_id INTEGER PRIMARY KEY AUTOINCREMENT,
    test_record_value TEXT NOT NULL,
    test_user_id  INT, --the user that the record belongs to
    FOREIGN KEY (test_user_id) REFERENCES testUsers(test_user_id)
);

--insert default data (if necessary here)

INSERT INTO testUsers ("test_name") VALUES ("Simon Star");
INSERT INTO testUserRecords ("test_record_value", "test_user_id") VALUES( "Lorem ipsum dolor sit amet", 1); --try changing the test_user_id to a different number and you will get an error

--**********************
-- My code starts here
--**********************

CREATE TABLE IF NOT EXISTS blog (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    subtitle TEXT NOT NULL,
    author TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS articles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    subtitle TEXT NOT NULL,
    textbox TEXT NOT NULL,
    author TEXT NOT NULL,
    likes INT NOT NULL,
    published BOOLEAN NOT NULL,
    creation_date TIMESTAMP NOT NULL,
    last_modified_date TIMESTAMP NOT NULL,
    published_date TIMESTAMP
);

CREATE TABLE IF NOT EXISTS comments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT,
    comment TEXT NOT NULL,
    creation_date TIMESTAMP NOT NULL,
    article_id INTEGER NOT NULL
);

-- testing values
INSERT INTO blog (title,subtitle,author) VALUES ("This is a title","This is a subtitle", "This is the author");
INSERT INTO articles (title,subtitle,textbox,author,likes,published,creation_date,last_modified_date,published_date)
VALUES("Article title 1","Article subtitle 1","Article text 1", "Article author 1", 0,1, 1689886281057,1689886281057,1689886281057),
("Article title 2","Article subtitle 2","Article text 2", "Article author 2", 0,1, 1689886281057,1689886281057,1689886281057);
INSERT INTO articles (title,subtitle,textbox,author,likes,published,creation_date,last_modified_date)
VALUES("Article title 3","Article subtitle 3","Article text 3", "Article author 3", 0,0, 1689886281057,1689886281057),
("Article title 4","Article subtitle 4","Article text 4", "Article author 4", 0,0, 1689886281057,1689886281057);


--**********************
-- My code ends here
--**********************


COMMIT;

