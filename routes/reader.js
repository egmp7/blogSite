/*********************  
 My code starts here 
 *********************/

/////////////////////////////////////////////////////////////
//  STATIC URLS

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

/////////////////////////////////////////////////////////////
//  DYNAMIC URLS

/**
 * @def Dynamic read article page
 */
router.get("/:id", getComments, (req, res, next) => {

  global.db.get(`SELECT * FROM articles WHERE id = ${req.params.id}`, function (err, article) {
    if (err) {
      next(err); 
    } 
    else {

      const isPublished = article.published

      if( isPublished ){
        res.render("article.ejs", {
          pageTitle: "Read article page",
          article,
          comments:req.commentsData
        });
      }else{

        res.redirect("/reader")
      }
    }
  });
});

/**
 * @def Stores comments in database
 */
router.post("/save-comment/:id",(req, res, next)=>{
  
  const data = req.body;

  global.db.run(`INSERT INTO comments (first_name,
                                      last_name,
                                      comment,
                                      creation_date,
                                      article_id) 
                  VALUES( ?, ?, ?, ?, ? )`,
  [data.firstName, data.lastName,data.commentText,Date.now(),req.params.id], 
  function (err, data) {
    if (err) {
      next(err); 
    } 
    else {
      res.redirect('back');
    }
  });
});

/**
 * @def Stores likes in articles
 */
router.get("/like-article/:id",(req, res, next)=>{
  
  const data = req.body;

  global.db.run(`UPDATE articles SET likes = likes +1 WHERE id = ${req.params.id}`, function (err, data) {
    if (err) {
      next(err); 
    } 
    else {
      res.redirect('back');
    }
  });
});

/////////////////////////////////////////////////////////////
//  MIDDLEWARE FUNCTIONS

/**
 * @def Middleware function to retrive data from blog table.
 * Data is stored as req.blogData
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

/**
 * @def Middleware function to retrive data from comments.
 * Data is stored as req.commentsData
 */
function getComments(req,res,next) {

  global.db.all(`SELECT * FROM comments WHERE article_id = ${req.params.id}`, 
  function (err, comments) {
    if (err) {
      next(err); 
    } 
    else {
      req.commentsData = comments
      next()
    }
  });
}

module.exports = router;

/*********************  
 My code ends here 
 *********************/