/*********************  
 My code starts here 
 *********************/

const express = require("express");
const { redirect } = require("express/lib/response");
const router = express.Router();

/**
 * @def Main reader page. Retrieves blog and article data
 */
router.get("/", getBlogData,(req, res, next) => {
  global.db.all("SELECT * FROM articles WHERE published = 1 ", 
  function (err, articles) {

    if (err) {
      next(err); 
    } else {
    
      res.render("reader.ejs", {
        pageTitle: "Reader's page",
        isAuthor: false,
        blog: req.blogData,
        articles
      });   
    }
  });
});

/**
 * @def Dynamic read article page
 */
router.get("/:id", (req, res, next) => {

  global.db.get(`SELECT * FROM articles WHERE id = ${req.params.id}`, function (err, article) {
    if (err) {
      next(err); 
    } 
    else {

      const isPublished = article.published

      if( isPublished ){
        res.render("article.ejs", {
          pageTitle: "Read article page",
          article
        });
      }else{

        res.redirect("/reader")
      }
    }
  });
});

/**
 * @def Middleware function to retrive data from blog table
 */
function getBlogData(req,res,next) {

  global.db.get("SELECT * FROM blog ORDER BY id DESC LIMIT 1", 
  function (err, blog) {
    if (err) {
      next(err); 
    } 
    else {
      req.blogData = blog
      next()
    }
  });
}

module.exports = router;

/*********************  
 My code ends here 
 *********************/