# Sparkle Unicorn Induction Tutor
This site is to server as a tutor/autograder for mathematical induction. This Readme will explain how to*
deploy and use the site. It will be broken into two major sections deployment and usage

## Deployment
Deployment is done through heroku allowing you to not have to worry about server issues. 
Before you are able to use and run the site make sure you have the following installed on your computer.
* Git
* Heroku CLI

Next run from a terminal do the following
* Download the repo using ```git clone THE_REPO_URL ```
* Type and run the following
 
 ``` 
     ssh-keygen -t rsa
     heroku login
     heroku keys:add
     heroku create
     git push heroku master
     heroku run bundle install
     heroku run rake db:migrate
```
* you should now be able to see the site with ``` heroku open ```

## Creating an Admin account
If you want to make yourself an admin account for the site the easiest way to do so is to ask another admin to upgrade your account. However if there are no other admins yet you will have to do the following
* Create any kind of account on the site as normal
* Visit data.heroku.com
* Select your deployment to view the database
* Select settings and click view database credentials
* Remember that password (its long and painful I know)
* Visit dashboard.heroku.com
* Select your deployment
* In the top right click on more
* Click on run console
* type ```rails db```
* Enter your password from earlier
* Type ```SELECT name, id, FROM users;```
* Remember the id associated to your account
* Type ```UPDATE users SET role = 1000 WHERE id = YOUR_ID;``` 
* your account should now be an admin account


## Tutorial
Now that the site is live it would be nice to know how to use it. Other than admins there are two other roles users can be on the site, Teachers and Students. Teachers create classes (called sections), questions, and tags (used to group questions, view the teacher section for more information). Students can enroll in classes made by Teachers and answer question created by them. All accounts must be made with a Google account.

### Teachers
As a Teacher you should be familiar with the following concepts.
* Questions
* Sections
* Tags
* Attempts

Using these you can create question sets and multiple classes used by many students

#### Questions
You can make a new questions from your My Questions page on the tag navigation bar. Questions have 5 parts,
* Title
* Val
* LHS
* RHS
* Tags

 The Question Title is the name you want to give that question and is what is shown in the tables the question comes from, the Val is what will be shown to the students when they click on the question, LHS is the left hand side of the equation you want students to solve, and RHS is the Right hand side of that equation. The tags are what set of questions you want this current one to be a part of.

 #### Sections
 Sections are the classes you are teaching they are available from your user page. They have 3 parts,
 * Name
 * Description
 * Tags

 The Name and Description are exactly as they sound serving a way for student to identify what class they should enroll in. The 
 Tags are which question sets you want available for this class to do.

#### Tags
Tags serve as a way for you to reuse questions in multiple classes and group related ones together they are available from your My Tags page. They have 4 parts,
* Name 
* Description
* Questions
* Sections

Once again the name and Description are just there for you to identify which tag you are looking for. The Questions and Sections are which Questions and Sections are associated to this tag. While you can't change them directly though the tag, they change when edited through the section or the question.

### Students
Students should be familiar with how to enter a proof (which will be covered in a later section) and how to enroll in classes.
Students enroll in classes from the enrollment tab. A list of all classes is avaliel from there and a link to add/drop is available from the table. Students can also drop classes from here.

## Language
//TODO

//should we put code related things here too for a future team?
