/*********************  
 My code starts here 
 *********************/

const express = require("express");
const router = express.Router();

/**
 * @def Main page. Retrieves blog and article data
 */
router.get("/", getBlogData, (req, res, next) => {

  global.db.all("SELECT * FROM articles", function (err, articles) {

    if (err) {
      next(err); 
    } else {

      // get data
      var data ={}
      data.articles = articles
      data.blog = req.blogData

      // render
      res.render("author.ejs", {
        title: "Author's page",
        data
      });   
    }
  });  
});

/**
 * @def Settings page. Retrieves blog data
 */
router.get("/settings", getBlogData, (req, res, next) => {

  res.render("settings.ejs", {
    title: "Settings's page",
    data:req.blogData
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

/**
 * @def Middleware function to retrive data from blog table
 */
function getBlogData(req,res,next) {

  global.db.all("SELECT * FROM blog ORDER BY blog_id DESC LIMIT 1", function (err, blogs) {
    if (err) {
      next(err); 
    } 
    else {
      req.blogData = blogs[0]
      next()
    }
  });
}

module.exports = router;

/*********************  
 My code ends here 
 *********************/