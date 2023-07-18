/*********************  
 My code starts here 
 *********************/

const express = require("express");
const router = express.Router();

/**
 * @def Main page. Retrieves blog and article data
 */
router.get("/", (req, res, next) => {

  var data ={}

  global.db.all("SELECT * FROM blog ORDER BY blog_id DESC LIMIT 1", function (err, blogs) {
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

/**
 * @def Settings page. Retrieves blog data
 */
router.get("/settings", (req, res, next) => {

  global.db.all("SELECT * FROM blog ORDER BY blog_id DESC LIMIT 1", function (err, blogs) {
    if (err) {
      next(err); //send the error on to the error handler
    } else {

      res.render("settings.ejs", {
        title: "Settings's page",
        data:blogs[0]
      });
    }
  });  
});

/**
 * @def Stores settings in blog tables.
 */
router.post("/edit-settings", (req, res, next) => {

  const data = req.body;
  
  global.db.run(
    "INSERT INTO blog (title,subtitle,author) VALUES( ?, ?, ? );",
    [data.blogTitle, data.blogSubtitle,data.blogAuthor],
    function (err) {
      if (err) {
        next(err); 
      } else {
        res.redirect("/author");
        next();
      }
    }
  );
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