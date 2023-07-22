/*********************  
 My code starts here 
 *********************/

const express = require("express");
const { redirect } = require("express/lib/response");
const router = express.Router();

/////////////////////////////////////////////////////////////
//  STATIC URLS

/**
 * @def Main author page. Retrieves blog and article data
 */
router.get("/", checkAuthorization, getBlogData, (req, res, next) => {

  global.db.all("SELECT * FROM articles ORDER BY creation_date DESC", function (err, articles) {

    if (err) {
      next(err); 
    } else {
      res.render("author.ejs", {
        pageTitle: "Author's page",
        blog: req.blogData,
        articles
      });   
    }
  });  
});

/**
 * @def Settings page. Retrieves blog data
 */
router.get("/settings", checkAuthorization, getBlogData, (req, res, next) => {

  res.render("settings.ejs", {
    pageTitle: "Settings's page",
    blog: req.blogData
  });
});

/**
 * @def Stores settings in blog tables.
 */
router.post("/edit-settings", checkAuthorization, (req, res, next) => {

  const data = req.body;
  
  global.db.run(
    "INSERT INTO blog (title,subtitle,author) VALUES( ?, ?, ? );",
    [data.blogTitle, data.blogSubtitle,data.blogAuthor],
    function (err) {
      if (err) {
        next(err); 
      } else {
        res.redirect("/author");
      }
    }
  );
});

/**
 * @def Creates a new draft article and 
 * redirects to the corresponding edit page.
 */
router.get("/create-new-draft", checkAuthorization, createDraft, (req, res, next) => {
  global.db.get("SELECT id FROM articles ORDER BY id DESC LIMIT 1", function (err, article) {
    if (err) {
      next(err); 
    } 
    else {
      res.redirect(`/author/edit/${article.id}`);
    }
  });
});

/////////////////////////////////////////////////////////////
//  DYNAMIC URLS

/**
 * @def Dynamic Edit article page
 */
router.get("/edit/:id", checkAuthorization, (req, res, next) => {

  global.db.get(`SELECT * FROM articles WHERE id = ${req.params.id}`, function (err, article) {
    if (err) {
      next(err); 
    } 
    else {
      res.render("edit.ejs", {
        pageTitle: "Edit page",
        article
      });  
    }
  });
});

/**
 * @def Saves article changes from the edit page
 */
router.post("/save-article/:id", checkAuthorization,(req, res, next)=>{
  
  const data = req.body;

  global.db.run(`UPDATE articles SET title = "${data.articleTitle}", 
                                    subtitle = "${data.articleSubtitle}", 
                                    author = "${data.articleAuthor}", 
                                    textbox = "${data.articleText}",
                                    last_modified_date = "${Date.now()}"
                                    WHERE id = ${req.params.id}`, 
  function (err, data) {
    if (err) {
      next(err); 
    } 
    else {
      res.redirect("/author")
    }
  });
});

/**
 * @def Publishes an article
 */
router.get("/publish-article/:id", checkAuthorization,(req, res, next)=>{
  global.db.run(`UPDATE articles SET published = 1, 
                                    published_date = ${Date.now()}
                                    WHERE id = ${req.params.id}`,
  function (err){
    if(err){
      next(err);
    } else{
      res.redirect("/author")
    }
  });
});

/**
 * @def Deletes an article from the database
 */
router.get("/delete-article/:id", checkAuthorization,(req, res, next)=>{
  global.db.run(`DELETE FROM articles WHERE id = ${req.params.id}`,
  function (err){
    if(err){
      next(err);
    } else{
      res.redirect("/author")
    }
  });
});

/////////////////////////////////////////////////////////////
//  AUTHORIZATION 

/**
 * @def Checks is user is logged in and renders the Login page.
 */
router.get("/login", (req, res, next) => {
  
  // if user already logged in
  if(req.session.user == 'active'){
    res.redirect("/author")
  }
  // else render loggin page
  else{
    res.render("login.ejs", {
      pageTitle: "Login page"
    });
  }
});

/**
 * @def Authentication for user
 */
router.post("/login", (req, res, next) => {
  if(req.body.user == 'user' && req.body.password == '123') {
    req.session.user = 'active';
    res.redirect("/author")
  }
  else res.redirect('back')
});

/**
 * @def Logouts the user from the current session
 */
router.get("/logout", (req, res, next) => {
  req.session.destroy(function(){
    console.log("user logged out.")
 });
  res.redirect("/reader")
  
});

/////////////////////////////////////////////////////////////
//  MIDDLEWARE FUNCTIONS

/**
 * @def Middleware function to create a new draft article
 */
function createDraft(req,res,next) {
  global.db.run(
    `INSERT INTO articles (title,
                          subtitle,
                          textbox,
                          author,likes,
                          published,
                          creation_date,
                          last_modified_date) 
    VALUES( ?, ?, ?, ?, ?, ?, ?, ? );`,
    ["title", "subtitle","text","author",0,0,Date.now(),Date.now()],
  function (err) {
    if (err) {
      next(err); 
    } else {
      next()
    }
  });
}

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

/**
 * @def Middleware function to check if user is logged in
 */
function checkAuthorization (req, res, next){
  if (req.session.user == 'active') next()
  else res.redirect("/author/login")
}

module.exports = router;

/*********************  
 My code ends here 
 *********************/