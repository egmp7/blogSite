/*********************  
 My code starts here 
 *********************/

const express = require("express");
const router = express.Router();

/**
 * @def Main route. Retrieves blog and article data
 */
router.get("/", (req, res, next) => {

  var data ={}

  global.db.all("SELECT * FROM blog LIMIT 1", function (err, blogs) {
    if (err) {
      next(err); //send the error on to the error handler
    } else {

      data.blog = blogs[0]

      global.db.all("SELECT * FROM articles", function (err, articles) {
        if (err) {
          next(err); //send the error on to the error handler
        } else {
          data.articles = articles
          //res.send(data)
          res.render("author.ejs", {
            title: "Author's page",
            data
          });   
        }
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