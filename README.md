# Notice of Claim

### What is this?

This is a small web app that simplifies the process of filling a "Notice of Claim" to the city of New York.

### Why?

New York law requires that anyone who wants to sue a “municipal entity” (for example, the NYPD) must file a “Notice of Claim” within 90 days of the incident. The notice of claim’s purported purpose is to allow the city to investigate a claim, and resolve the matter before the plaintiff files a lawsuit. This can be confusing for lawyers and the public alike, because a Notice of Claim is not a requirement for most other types of lawsuit. Although the information required for a Notice of Claim is very simple, the short statute of limitations presents a major obstacle for plaintiffs.

Currently, many plaintiffs are failing to file a Notice of Claim within the 90 day statute of limitations. Often, victims of police violence or an illegal arrest spend the 90 days after the incident addressing other concerns stemming from the consequences of being jailed, or seeking medical attention. By the time a plaintiff realizes that they may benefit from bringing a case against the NYPD, the extremely brief statute of limitations has expired. As a result, many people with legitimate claims of police abuse will never be able to have those claims heard by the court. 

This app seeks to streamline the process for plaintiffs and attorneys who deal frequently with populations at high risk of police violence. By using the app, an attorney or plaintiff can preserve a claim as soon as possible, giving the plaintiff time to find an attorney who can bring the lawsuit to court. 

### Setup and run

These setup instructions assume you have [Ruby](https://www.ruby-lang.org/en/) and [PostgreSQL](http://www.postgresql.org/) installed. If you don't, the RailsApps Project has great tutorials [here](http://railsapps.github.io/installing-rails.html).

Start PostgreSQL. Download and setup:

```
git clone https://github.com/rcackerman/notice-of-claim.git
cd notice-of-claim
bundle install
rake db:create
rake db:setup
```

You should be set to go! To run the app:

```
rails server
```

Rails will tell you what url to go to in order to view the site.

### Errors / Bugs

If something is not behaving intuitively, it is a bug, and should be reported.
Report it here: https://github.com/rcackerman/notice-of-claim/issues

Extra credit if you recommend changes that make the Readme easier to use.

### Want to Contribute?

Please check out the [issues page](https://github.com/notice-of-claim/issues/) and help out with any that have a "helpwanted" tag! Just create a fork and submit a pull request when you're done.

### Team

The Notice of Claim app is being built by [Rebecca Ackerman](https://github.com/rcackerman), in collaboration with [Jason Tashea, JD](https://twitter.com/jtashea) and Samuel Natale, JD.
