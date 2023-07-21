
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
INSERT INTO blog (title,subtitle,author) VALUES ("Day's Gone","Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", "Mario Tesla");
INSERT INTO articles (title,subtitle,textbox,author,likes,published,creation_date,last_modified_date,published_date)
VALUES("Tesla's innovation","Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.","Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Gravida dictum fusce ut placerat orci nulla pellentesque dignissim enim. Scelerisque fermentum dui faucibus in ornare quam viverra orci. Suspendisse potenti nullam ac tortor vitae. Dignissim diam quis enim lobortis scelerisque. Nunc vel risus commodo viverra maecenas. Augue ut lectus arcu bibendum at varius vel pharetra vel. Lacus laoreet non curabitur gravida arcu ac tortor dignissim convallis. Orci eu lobortis elementum nibh tellus. Laoreet suspendisse interdum consectetur libero. Nulla malesuada pellentesque elit eget.

Nunc mattis enim ut tellus elementum sagittis vitae et. Ultricies lacus sed turpis tincidunt id aliquet risus. Eget dolor morbi non arcu risus. Ut faucibus pulvinar elementum integer enim neque volutpat ac tincidunt. Elementum tempus egestas sed sed risus pretium quam vulputate dignissim. Amet dictum sit amet justo. Suscipit adipiscing bibendum est ultricies integer. Venenatis urna cursus eget nunc scelerisque viverra mauris. Eu lobortis elementum nibh tellus molestie nunc. Nibh cras pulvinar mattis nunc sed. Non arcu risus quis varius quam quisque. Duis ut diam quam nulla. Amet luctus venenatis lectus magna fringilla urna porttitor. Mauris ultrices eros in cursus turpis massa tincidunt. Nisi vitae suscipit tellus mauris a diam. Ut tortor pretium viverra suspendisse. Velit dignissim sodales ut eu sem integer vitae justo eget. Sit amet luctus venenatis lectus magna fringilla. Ultrices gravida dictum fusce ut placerat orci nulla pellentesque dignissim.

At ultrices mi tempus imperdiet nulla malesuada pellentesque. In egestas erat imperdiet sed euismod nisi porta. Nullam non nisi est sit amet facilisis magna etiam tempor. Gravida neque convallis a cras semper auctor neque vitae tempus. Blandit aliquam etiam erat velit scelerisque in dictum non. Ut sem viverra aliquet eget. Vestibulum sed arcu non odio euismod lacinia at. Pretium nibh ipsum consequat nisl. Vivamus arcu felis bibendum ut tristique et. Pharetra sit amet aliquam id diam maecenas ultricies mi.

A pellentesque sit amet porttitor eget dolor morbi non arcu. Massa sapien faucibus et molestie. Proin sagittis nisl rhoncus mattis rhoncus urna. Nisl suscipit adipiscing bibendum est ultricies integer quis. Duis ut diam quam nulla porttitor massa id neque aliquam. Morbi leo urna molestie at elementum eu facilisis. Vel turpis nunc eget lorem dolor sed. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Volutpat sed cras ornare arcu dui vivamus arcu felis. Turpis massa sed elementum tempus egestas. Velit ut tortor pretium viverra suspendisse potenti. Metus vulputate eu scelerisque felis. Facilisis magna etiam tempor orci eu lobortis elementum nibh tellus. Sem integer vitae justo eget magna fermentum iaculis eu non. Aliquet risus feugiat in ante metus dictum at tempor commodo.

Tortor posuere ac ut consequat semper viverra. Molestie a iaculis at erat pellentesque adipiscing commodo elit. Mattis nunc sed blandit libero volutpat sed. Egestas integer eget aliquet nibh praesent tristique. Amet massa vitae tortor condimentum. Arcu vitae elementum curabitur vitae nunc sed velit dignissim. Vel quam elementum pulvinar etiam non quam lacus suspendisse faucibus. Etiam sit amet nisl purus in mollis nunc sed id. Tristique sollicitudin nibh sit amet. Mauris cursus mattis molestie a iaculis at. Varius sit amet mattis vulputate. Ultrices mi tempus imperdiet nulla malesuada pellentesque. Massa id neque aliquam vestibulum morbi blandit cursus risus at. Velit dignissim sodales ut eu sem integer vitae justo. Sed viverra ipsum nunc aliquet bibendum enim facilisis gravida neque. Tellus in metus vulputate eu. Ut sem nulla pharetra diam. Auctor urna nunc id cursus metus aliquam eleifend mi.", "Mario Tesla", 0,1, 1689886281057,1689886281057,1689886281057),
("Kia's innovation for the new days to come","Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.","Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Gravida dictum fusce ut placerat orci nulla pellentesque dignissim enim. Scelerisque fermentum dui faucibus in ornare quam viverra orci. Suspendisse potenti nullam ac tortor vitae. Dignissim diam quis enim lobortis scelerisque. Nunc vel risus commodo viverra maecenas. Augue ut lectus arcu bibendum at varius vel pharetra vel. Lacus laoreet non curabitur gravida arcu ac tortor dignissim convallis. Orci eu lobortis elementum nibh tellus. Laoreet suspendisse interdum consectetur libero. Nulla malesuada pellentesque elit eget.

Nunc mattis enim ut tellus elementum sagittis vitae et. Ultricies lacus sed turpis tincidunt id aliquet risus. Eget dolor morbi non arcu risus. Ut faucibus pulvinar elementum integer enim neque volutpat ac tincidunt. Elementum tempus egestas sed sed risus pretium quam vulputate dignissim. Amet dictum sit amet justo. Suscipit adipiscing bibendum est ultricies integer. Venenatis urna cursus eget nunc scelerisque viverra mauris. Eu lobortis elementum nibh tellus molestie nunc. Nibh cras pulvinar mattis nunc sed. Non arcu risus quis varius quam quisque. Duis ut diam quam nulla. Amet luctus venenatis lectus magna fringilla urna porttitor. Mauris ultrices eros in cursus turpis massa tincidunt. Nisi vitae suscipit tellus mauris a diam. Ut tortor pretium viverra suspendisse. Velit dignissim sodales ut eu sem integer vitae justo eget. Sit amet luctus venenatis lectus magna fringilla. Ultrices gravida dictum fusce ut placerat orci nulla pellentesque dignissim.

At ultrices mi tempus imperdiet nulla malesuada pellentesque. In egestas erat imperdiet sed euismod nisi porta. Nullam non nisi est sit amet facilisis magna etiam tempor. Gravida neque convallis a cras semper auctor neque vitae tempus. Blandit aliquam etiam erat velit scelerisque in dictum non. Ut sem viverra aliquet eget. Vestibulum sed arcu non odio euismod lacinia at. Pretium nibh ipsum consequat nisl. Vivamus arcu felis bibendum ut tristique et. Pharetra sit amet aliquam id diam maecenas ultricies mi.

A pellentesque sit amet porttitor eget dolor morbi non arcu. Massa sapien faucibus et molestie. Proin sagittis nisl rhoncus mattis rhoncus urna. Nisl suscipit adipiscing bibendum est ultricies integer quis. Duis ut diam quam nulla porttitor massa id neque aliquam. Morbi leo urna molestie at elementum eu facilisis. Vel turpis nunc eget lorem dolor sed. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Volutpat sed cras ornare arcu dui vivamus arcu felis. Turpis massa sed elementum tempus egestas. Velit ut tortor pretium viverra suspendisse potenti. Metus vulputate eu scelerisque felis. Facilisis magna etiam tempor orci eu lobortis elementum nibh tellus. Sem integer vitae justo eget magna fermentum iaculis eu non. Aliquet risus feugiat in ante metus dictum at tempor commodo.

Tortor posuere ac ut consequat semper viverra. Molestie a iaculis at erat pellentesque adipiscing commodo elit. Mattis nunc sed blandit libero volutpat sed. Egestas integer eget aliquet nibh praesent tristique. Amet massa vitae tortor condimentum. Arcu vitae elementum curabitur vitae nunc sed velit dignissim. Vel quam elementum pulvinar etiam non quam lacus suspendisse faucibus. Etiam sit amet nisl purus in mollis nunc sed id. Tristique sollicitudin nibh sit amet. Mauris cursus mattis molestie a iaculis at. Varius sit amet mattis vulputate. Ultrices mi tempus imperdiet nulla malesuada pellentesque. Massa id neque aliquam vestibulum morbi blandit cursus risus at. Velit dignissim sodales ut eu sem integer vitae justo. Sed viverra ipsum nunc aliquet bibendum enim facilisis gravida neque. Tellus in metus vulputate eu. Ut sem nulla pharetra diam. Auctor urna nunc id cursus metus aliquam eleifend mi.", "Mario Tesla", 0,1, 1689886281057,1689886281057,1689886281057);
INSERT INTO articles (title,subtitle,textbox,author,likes,published,creation_date,last_modified_date)
VALUES("Boats go faster than cars with k7 engines","Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.","Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Gravida dictum fusce ut placerat orci nulla pellentesque dignissim enim. Scelerisque fermentum dui faucibus in ornare quam viverra orci. Suspendisse potenti nullam ac tortor vitae. Dignissim diam quis enim lobortis scelerisque. Nunc vel risus commodo viverra maecenas. Augue ut lectus arcu bibendum at varius vel pharetra vel. Lacus laoreet non curabitur gravida arcu ac tortor dignissim convallis. Orci eu lobortis elementum nibh tellus. Laoreet suspendisse interdum consectetur libero. Nulla malesuada pellentesque elit eget.

Nunc mattis enim ut tellus elementum sagittis vitae et. Ultricies lacus sed turpis tincidunt id aliquet risus. Eget dolor morbi non arcu risus. Ut faucibus pulvinar elementum integer enim neque volutpat ac tincidunt. Elementum tempus egestas sed sed risus pretium quam vulputate dignissim. Amet dictum sit amet justo. Suscipit adipiscing bibendum est ultricies integer. Venenatis urna cursus eget nunc scelerisque viverra mauris. Eu lobortis elementum nibh tellus molestie nunc. Nibh cras pulvinar mattis nunc sed. Non arcu risus quis varius quam quisque. Duis ut diam quam nulla. Amet luctus venenatis lectus magna fringilla urna porttitor. Mauris ultrices eros in cursus turpis massa tincidunt. Nisi vitae suscipit tellus mauris a diam. Ut tortor pretium viverra suspendisse. Velit dignissim sodales ut eu sem integer vitae justo eget. Sit amet luctus venenatis lectus magna fringilla. Ultrices gravida dictum fusce ut placerat orci nulla pellentesque dignissim.

At ultrices mi tempus imperdiet nulla malesuada pellentesque. In egestas erat imperdiet sed euismod nisi porta. Nullam non nisi est sit amet facilisis magna etiam tempor. Gravida neque convallis a cras semper auctor neque vitae tempus. Blandit aliquam etiam erat velit scelerisque in dictum non. Ut sem viverra aliquet eget. Vestibulum sed arcu non odio euismod lacinia at. Pretium nibh ipsum consequat nisl. Vivamus arcu felis bibendum ut tristique et. Pharetra sit amet aliquam id diam maecenas ultricies mi.

A pellentesque sit amet porttitor eget dolor morbi non arcu. Massa sapien faucibus et molestie. Proin sagittis nisl rhoncus mattis rhoncus urna. Nisl suscipit adipiscing bibendum est ultricies integer quis. Duis ut diam quam nulla porttitor massa id neque aliquam. Morbi leo urna molestie at elementum eu facilisis. Vel turpis nunc eget lorem dolor sed. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Volutpat sed cras ornare arcu dui vivamus arcu felis. Turpis massa sed elementum tempus egestas. Velit ut tortor pretium viverra suspendisse potenti. Metus vulputate eu scelerisque felis. Facilisis magna etiam tempor orci eu lobortis elementum nibh tellus. Sem integer vitae justo eget magna fermentum iaculis eu non. Aliquet risus feugiat in ante metus dictum at tempor commodo.

Tortor posuere ac ut consequat semper viverra. Molestie a iaculis at erat pellentesque adipiscing commodo elit. Mattis nunc sed blandit libero volutpat sed. Egestas integer eget aliquet nibh praesent tristique. Amet massa vitae tortor condimentum. Arcu vitae elementum curabitur vitae nunc sed velit dignissim. Vel quam elementum pulvinar etiam non quam lacus suspendisse faucibus. Etiam sit amet nisl purus in mollis nunc sed id. Tristique sollicitudin nibh sit amet. Mauris cursus mattis molestie a iaculis at. Varius sit amet mattis vulputate. Ultrices mi tempus imperdiet nulla malesuada pellentesque. Massa id neque aliquam vestibulum morbi blandit cursus risus at. Velit dignissim sodales ut eu sem integer vitae justo. Sed viverra ipsum nunc aliquet bibendum enim facilisis gravida neque. Tellus in metus vulputate eu. Ut sem nulla pharetra diam. Auctor urna nunc id cursus metus aliquam eleifend mi.", "Mario Tesla", 0,0, 1689886281057,1689886281057),
("CAT creates new engines 12v","Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.","Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Gravida dictum fusce ut placerat orci nulla pellentesque dignissim enim. Scelerisque fermentum dui faucibus in ornare quam viverra orci. Suspendisse potenti nullam ac tortor vitae. Dignissim diam quis enim lobortis scelerisque. Nunc vel risus commodo viverra maecenas. Augue ut lectus arcu bibendum at varius vel pharetra vel. Lacus laoreet non curabitur gravida arcu ac tortor dignissim convallis. Orci eu lobortis elementum nibh tellus. Laoreet suspendisse interdum consectetur libero. Nulla malesuada pellentesque elit eget.

Nunc mattis enim ut tellus elementum sagittis vitae et. Ultricies lacus sed turpis tincidunt id aliquet risus. Eget dolor morbi non arcu risus. Ut faucibus pulvinar elementum integer enim neque volutpat ac tincidunt. Elementum tempus egestas sed sed risus pretium quam vulputate dignissim. Amet dictum sit amet justo. Suscipit adipiscing bibendum est ultricies integer. Venenatis urna cursus eget nunc scelerisque viverra mauris. Eu lobortis elementum nibh tellus molestie nunc. Nibh cras pulvinar mattis nunc sed. Non arcu risus quis varius quam quisque. Duis ut diam quam nulla. Amet luctus venenatis lectus magna fringilla urna porttitor. Mauris ultrices eros in cursus turpis massa tincidunt. Nisi vitae suscipit tellus mauris a diam. Ut tortor pretium viverra suspendisse. Velit dignissim sodales ut eu sem integer vitae justo eget. Sit amet luctus venenatis lectus magna fringilla. Ultrices gravida dictum fusce ut placerat orci nulla pellentesque dignissim.

At ultrices mi tempus imperdiet nulla malesuada pellentesque. In egestas erat imperdiet sed euismod nisi porta. Nullam non nisi est sit amet facilisis magna etiam tempor. Gravida neque convallis a cras semper auctor neque vitae tempus. Blandit aliquam etiam erat velit scelerisque in dictum non. Ut sem viverra aliquet eget. Vestibulum sed arcu non odio euismod lacinia at. Pretium nibh ipsum consequat nisl. Vivamus arcu felis bibendum ut tristique et. Pharetra sit amet aliquam id diam maecenas ultricies mi.

A pellentesque sit amet porttitor eget dolor morbi non arcu. Massa sapien faucibus et molestie. Proin sagittis nisl rhoncus mattis rhoncus urna. Nisl suscipit adipiscing bibendum est ultricies integer quis. Duis ut diam quam nulla porttitor massa id neque aliquam. Morbi leo urna molestie at elementum eu facilisis. Vel turpis nunc eget lorem dolor sed. Risus viverra adipiscing at in tellus integer feugiat scelerisque varius. Volutpat sed cras ornare arcu dui vivamus arcu felis. Turpis massa sed elementum tempus egestas. Velit ut tortor pretium viverra suspendisse potenti. Metus vulputate eu scelerisque felis. Facilisis magna etiam tempor orci eu lobortis elementum nibh tellus. Sem integer vitae justo eget magna fermentum iaculis eu non. Aliquet risus feugiat in ante metus dictum at tempor commodo.

Tortor posuere ac ut consequat semper viverra. Molestie a iaculis at erat pellentesque adipiscing commodo elit. Mattis nunc sed blandit libero volutpat sed. Egestas integer eget aliquet nibh praesent tristique. Amet massa vitae tortor condimentum. Arcu vitae elementum curabitur vitae nunc sed velit dignissim. Vel quam elementum pulvinar etiam non quam lacus suspendisse faucibus. Etiam sit amet nisl purus in mollis nunc sed id. Tristique sollicitudin nibh sit amet. Mauris cursus mattis molestie a iaculis at. Varius sit amet mattis vulputate. Ultrices mi tempus imperdiet nulla malesuada pellentesque. Massa id neque aliquam vestibulum morbi blandit cursus risus at. Velit dignissim sodales ut eu sem integer vitae justo. Sed viverra ipsum nunc aliquet bibendum enim facilisis gravida neque. Tellus in metus vulputate eu. Ut sem nulla pharetra diam. Auctor urna nunc id cursus metus aliquam eleifend mi.", "Mario Tesla", 0,0, 1689886281057,1689886281057);


--**********************
-- My code ends here
--**********************


COMMIT;

