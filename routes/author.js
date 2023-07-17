/*********************  
 My code starts here 
 *********************/

const express = require("express");
const router = express.Router();

router.get("/", (req, res, next) => {

  global.db.all("SELECT * FROM blog LIMIT 1", function (err, rows) {
    if (err) {
      next(err); //send the error on to the error handler
    } else {
      res.render("author.ejs", {
        title: "Author's page",
        blog:rows[0]
      });      
    }
  });
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