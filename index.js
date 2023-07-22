const express = require('express');
const app = express();
const port = 3000;
const sqlite3 = require('sqlite3').verbose();

//items in the global namespace are accessible throught out the node application
global.db = new sqlite3.Database('./database.db',function(err){
  if(err){
    console.error(err);
    process.exit(1); //Bail out we can't connect to the DB
  }else{
    console.log("Database connected");
    global.db.run("PRAGMA foreign_keys=ON"); //This tells SQLite to pay attention to foreign key constraints
  }
});


const userRoutes = require('./routes/user');

//set the app to use ejs for rendering
app.set('view engine', 'ejs');

//this adds all the userRoutes to the app under the path /user
app.use('/user', userRoutes);

/*********************  
 My code starts here 
*********************/

// Express Sesions
var session = require('express-session');
app.use(session({secret: "The secret key"}));

// Static files
app.use(express.static('public'))

// bootstrap
app.use('/css', express.static(__dirname + '/node_modules/bootstrap/dist/css'));

// body parser
const bodyParser= require ("body-parser");
app.use(bodyParser.urlencoded({ extended: true }));

// Author route
const authorRoutes = require('./routes/author');
app.use('/author', authorRoutes);

// Reader route
const readerRoutes = require('./routes/reader');
app.use('/reader', readerRoutes);

/*********************  
 My code ends here 
*********************/

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

