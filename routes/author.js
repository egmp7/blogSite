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

/**
 * @def Creates a new draft article and 
 * redirects to the corresponding edit page.
 */
router.get("/create-new-draft", createDraft, (req, res, next) => {
  global.db.all("SELECT article_id FROM articles ORDER BY article_id DESC LIMIT 1", function (err, data) {
    if (err) {
      next(err); 
    } 
    else {
      const id = data[0].article_id
      res.redirect(`/author/edit/${id}`);
    }
  });
});

/**
 * @def Dynamic Edit article page
 */
router.get("/edit/:id", (req, res, next) => {

  res.render("edit.ejs", {
    title: "Edit page"
  });  
});

/**
 * @def Middleware function to create a new draft article
 */
function createDraft(req,res,next) {
  global.db.run(
    "INSERT INTO articles (title,subtitle,article_text,author,likes,published,creation_date,last_modified_date) VALUES( ?, ?, ?, ?, ?, ?, ?, ? );",
    ["title", "subtitle","text","author",0,0,Date.now(),Date.now()],
    function (err) {
      if (err) {
        next(err); 
      } else {
        next()
      }
    }
  );
}

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