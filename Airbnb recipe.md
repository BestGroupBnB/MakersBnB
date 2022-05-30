# {{PROBLEM}} Web Design Recipe (Level Three)

## 1. Describe the Problem
_Put or write the user stories here. Add any clarifying notes you might have._

Tickets:

1. Any signed-up user can list a new space.
   - A user can "sign-up" to the AirBnb board   
   - user can list a new space on an AirBnb board

2. Users can list multiple spaces.
 - User can list multiple spaces

3. Users should be able to name their space, provide a short description of the space, and a price per night.
 - User can add the above details to the space

4. Users should be able to offer a range of dates where their space is available.
 - User can select a "from" and "to" date when listing a space, showing the date range on the listing

5. Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
 - A signed up user can request a space for one night
 - The spaces owner can confirm/deny the request

6. Nights for which a space has already been booked should not be available for users to book that space.
 - User should not be able to book during the "from" and "to" date range of the listing

7. Until a user has confirmed a booking request, that space can still be booked for that night.
 - Multiple user can request a booking for a night
 - When a user booking is confirmed, other requests are denied


## 2. Design the Interface

_This is the fun part! Use excalidraw.com or a similar tool to design some
wireframes (rough sketches of the user interface). Include interactions and
transitions between pages — those are the most critical part._

![Diary design example](./diary_design.png)

*Created Advert design example and put in Recipe folder*



## 3. Design the Database

_Design the data tables that will store all of the information your application
manages. Include the data types and examples of three rows. Consider use Google
Sheets or [AsciiTable](https://ozh.github.io/ascii-tables/) to do this._

<!-- ```plain
# Example

Table name: diary_entries

| id (NUMBER) |  title (TEXT)   |     contents (TEXT)      |
|-------------|-----------------|--------------------------|
|           1 | What a nice day | Today was a great day... |
|           2 | What a bad day  | Today was an awful da... |
|           3 | What a cool day | Today was a cool day ... |
``` -->

## 4. Create Examples of User Interactions

_Create examples of user interactions and expectations._

```ruby
# As you learn the testing tools you might start writing with realistic test
# code here, but at the start it's OK if it's just English or made up code.

# View no entries
visit "/advert"

# visit "/diary"
# User sees: You have no diary entries.

# Add an entry
visit "/diary"
click link "Add Entry"
enter "A beautiful day" into "Title" field
enter "I had a very nice day it's true." into "Contents" field
click button "Post"
# User sees in the diary list:
# A beautiful day
# I had a very nice day it's true.

# Multiple entries
visit "/diary"
click link "Add Entry"
enter "A beautiful day" into "Title" field
enter "I had a very nice day it's true." into "Contents" field
click button "Post"
click link "Add Entry"
enter "A bad day" into "Title" field
enter "I had a very bad day." into "Contents" field
click button "Post"
# User sees in the diary list:
# A bad day
# I had a very bad day.
# A beautiful day
# I had a very nice day it's true.
```

## 6. Test-Drive the Behaviour

_Follow this cycle:_

1. Add a feature test in `/spec/feature/` (RED)
2. Implement the behaviour in `app.rb`
3. Does it pass without data model changes? (GREEN) Then skip to step 6.
4. Otherwise, add a unit test for the data model to `/spec/unit` (RED)
5. Implement the behaviour in your data model class. (GREEN)
6. Apply any refactors to improve the structure of the code. (REFACTOR)  
   Run `rubocop` as part of this.
7. Go back to step 1.


<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/web-starter-level-three&prefill_File=recipe/recipe.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/web-starter-level-three&prefill_File=recipe/recipe.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/web-starter-level-three&prefill_File=recipe/recipe.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/web-starter-level-three&prefill_File=recipe/recipe.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/web-starter-level-three&prefill_File=recipe/recipe.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->
