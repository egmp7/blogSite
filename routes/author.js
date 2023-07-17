/*********************  
 My code starts here 
 *********************/

const express = require("express");
const router = express.Router();

router.get("/", (req, res, next) => {

  res.render("author.ejs", {
    title: "Author's page"
  });
    //Use this pattern to retrieve data
    //NB. it's better NOT to use arrow functions for callbacks with this library
    // global.db.all("SELECT * FROM testUsers", function (err, rows) {
    //   if (err) {
    //     next(err); //send the error on to the error handler
    //   } else {
    //     res.json(rows);
    //   }
    // });
    
});

router.get("/settings", (req, res, next) => {

  res.render("settings.ejs", {
    title: "Settings's page"
  });  
});

router.get("/edit", (req, res, next) => {

  res.render("edit.ejs", {
    title: "Edit page"
  });  
});

module.exports = router;

/*********************  
 My code ends here 
 *********************/