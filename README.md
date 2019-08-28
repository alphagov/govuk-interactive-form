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
