# Induction Tutor

More details to come

## Setup

* Go to console.aws.com
* Set email to `806198832592`
* Login using your IAM account and password
* Navigate to Cloud9
* Create a new environment
  * Set the environment name to your github name
  * Use the default settings
* Boot into your environment
* Create a new branch
  * Set your branch name to your github name
* Right click `Run` at the top of the screen and create a `New Run Configuration`
  * give it a name
  * Set the command to `rails s -b 0.0.0.0`
  * Verify the Runner is `Shell command`
  * Set the CWD to the `induction` directory
  * Hit run
    * If successful, it will say something along the lines of `Listening on tcp://0.0.0.0:8080`
* Click `Preview` at the top of the screen and click `Preview Running Application`
  * This will open a browser in Cloud9
  * Hit the button to the right of the `Browser` dropdown to open in a new window
  * You should now see the running application
    * Refresh the page to see changes without restarting 

## Contributing

* Please develop on your own branch. That way any crippling errors you encounter during development doesn't screw up anyone else
* Pair programming should be easy on Cloud9, we should probably use it at least once
* When you finish a feature, create a pull request from your branch to master and let someone else review it
* Let's use TDD 
* run `git merge origin/master` frequently and deal with any merge conflicts within your branch!