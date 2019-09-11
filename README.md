# README

Govuk Interactive Form allows you to easily pose questions to users and collect their answers in a 'fun' form

![screenshot](docs/screenshot.png)


## Running

You'll need postgres and Ruby. To start it, just do:
```
bundle install
rake db:setup
rails s
```
You should then be able to visit `localhost:3000/example` to play with the example questions




## Setting up

The app a little config to set up your questions. 

* Firstly, make a csv file with all your questions. It should have the following fields as headers


| id                                           | question                           | content                                                      | url                                                          |
|----------------------------------------------|------------------------------------|--------------------------------------------------------------|--------------------------------------------------------------|
| ID of the question, can be numeric or string | The question put to the user       | HTML content that will help a user decide. Can be left blank | Optional URL to display in an iframe                         |
| 1                                            | Are these search results relevant? |                                                              | https://www.gov.uk/search/all?keywords=taxid&order=relevance |
|                                              | Is Ruby better than Python         | <p>Clearly, Ruby is superior.</p>                            |                                                              |

* Now, make another CSV with the buttons that will be displayed to you users. Of the form:

| text                                                                  | swipe_direction                                                                                                              |
|-----------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|
| Text to go in the button. This will be saved to the db as your answer | Direction the item should go to when chosen, value can be `left`, `right` or blank. Blank will result in the item fading out |
| Yes                                                                   | right                                                                                                                        |
| No                                                                    | left                                                                                                                         |
| Maybe                                                                 |                                                                                                                              |

* Put the files in the data directory.
* Now in `config/items.yml` add references to your files.
```
production:
    name_for_my_questions:
        item_file: "my_questions.csv"
        answers_file: "my_answers.csv"
```

Please note, it isn't necessary to include the `data/` prefix. You can also copy the example configuration and adapt to your needs.

* Now you're ready to go! The `name_for_my_questions` field in the yaml file will now be available as an endpoint, so in this example you'd go to `localhost:3000/name_for_my_questions`
* As users answer the questions, it'll create Answer records with all the relevant information, you can query the answers for your questions with something like `Answer.where(collection: "example")` 

## Reviewing answers

When your users have all answered the questions you've posed, there are a couple of rake tasks to export all the data.

Currently, the best way to do this is to download the postgres database from Heroku, import it into your local db and run the tasks. In the future, it may be easier for the tasks to upload the results to an AWS S3 bucket.

For the time being, download a backup of the Heroku database; either through the web interface or by following the instructions on [this guide](https://devcenter.heroku.com/articles/heroku-postgres-import-export).

Next, rename the file to 'database' and move it to the folder above your govuk-interactive-form repo folder (to prevent accidentally adding sensitive data to Git)

Run `pg_restore -h localhost -d govuk_interactive_form_development ../database` to import the database into your local PG instance (you may need to add the database and set requisite user permissions first).

Then you can run 'rake export_collection[name_for_my_questions_as_set_in_items.yml]' to export a raw csv of all the answers to your questions or 'rake export_decisions[name_for_my_questions_as_set_in_items.yml]' to get a tallied list of how many times each answer was given for each question. 
