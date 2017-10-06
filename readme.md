I am the readme. By reading me, you have done yourself a great favour.
===

Here is the link to my meal suggestor app:
[Check it out!](https://still-plateau-90455.herokuapp.com/ "Meal Suggester App")

This is a simple web app built with ruby/sinatra/activerecord and psql.

The original aim of the app was to allow users to create an account, post their meal recipes, 'like' recipes they think are good, and then have quick access to recipes that will appeal to them.

---

The technologies used:
⋅⋅*Sinatra for handling the routes/requests and the ability to check progress during development with localhosting.
⋅⋅*Activerecord for handling database queries using ORM.
⋅⋅*PSQL for database and table creation.
⋅⋅* Heroku for live deployment of the app upon completion.

My plan was:

⋅⋅*The home page would list the three meals with the most likes as well as the three most recent meals posted.

⋅⋅*The profile page would list, *I* *originally* *hoped,* three meals recommended to the user based on the likes of *other* users who had liked the same meals as the current user. I quickly learned that my idea was lofty to the point of impossible given the time frame and our experience with the tools we are using. As a compromise, I have displayed the recommendations on a users profile page as a random selection of three meals from all of the meals.

⋅⋅*The all meals page displays all the meals that have been posted, this was necessary as i had truncated all the other lists of meals to the 'top' three.

⋅⋅*Users can click on any meal to open a meal details page outlining the ingridients and method for making the meal. Users can also like a meal and either edit or delete any meal they have created.

---

The things I would like to improve:

⋅⋅*The algorithm I originally intended to use to recommend three dishes to the user. I might not be able to make it as complex or accurate as I had originally imagined, but I would like to make it at least based on some kind of relavant information, not just random. One idea is to create a 'tag' column in the meals table and allow people to tag the kind of meal something is. This would allow me to count the number of (for example) cakes, pastas, or egg dishes someone has liked, and recommend another dish of the same sort based on this.

⋅⋅*The STYLING! The lack of styling is due to a lack of time left over after adding the functionality necessary to have a MVP. Given a little more time, and refreshing my knowledge of CSS I think I could make the app look a lot better.

⋅⋅*I would also like to add the ability for users to add comments to meals, which would be displayed on the meal details page when a user selects a meal.

⋅⋅*Validations! The final piece of the puzzle would be locking down all the data-types and formats that are allowed whenever a user is entering information.