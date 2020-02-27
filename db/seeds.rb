collection_name = "example_database"

question_one_answer_one = { key: "yes", text: "I am going to make it through this year, if it kills me" }
question_one_answer_two = { key: "certainly", text: "I am going to make it through this year, if it kills me" }
Question.create(
  collection: collection_name,
  question: "Are you going to make it through this year?",
  content: "<p>Are you?</p>",
  answers: [question_one_answer_one, question_one_answer_two]
)

question_two_answer_one = { key: "sort_of", text: "There will only be feasting" }
question_two_answer_two = { key: "yes", text: "There will be feasting and dancing" }
Question.create(
  collection: collection_name,
  question: "What will happen next year?",
  content: "<p>Care to make a prediction?</p>",
  answers: [question_two_answer_one, question_two_answer_two]
)
