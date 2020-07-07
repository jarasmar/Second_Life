# SECOND LIFE

Our society moves at a dizzying pace. New technologies and the concept of fast fashion cause us to get rid of our belongings more and more often. Jeans from last season are no longer in fashion, and that lamp no longer matches your new cushion. And it is so easy to replace them... Unfortunately our planet does not have unlimited resources, our landfills are full and those objects that you do not want deserve a “Second Life”.

#### Key Words
Upcycle - Environment - Recycle - Community - Second Hand - Share - Neighbourhood - Creativity - DIY

## How does it work?
An app based on Google Maps API where users can mark the exact location of any kind of goods left on the street for other people to collect or for the rubbish collection service to take away if the item has been left there for too long. Posts can be made by the previous owner (the person leaving the goods for other to take) or by any other user that sees goods on the street (just need to take a picture and post it with the location).

## FEATURES
>owner = user posting an item that can be collected

>client = user collecting an item that has been posted

### Two Main Views
- **Main View:** Grid of posted items (image, title, begining of description, location, links) - Filter by (nearby, newest, tag) - Change to Map View
- **Map View:** Map with pins (on click: image, title, begining of description, location, links) - Filter by (nearby, newest, tag) - Change to List View

### Posts
- **Post Page:** picture, title, description, location, checklist (list of objects available), date and time, tags, map.
- **Availability:** client can mark items in the checklist if collected (1 point for owner) - owner can mark items as gone in the checklist too. Display the last time a post was updated.

### Users
- **Registration:** username, email, password, profile picture.
- **User Page:** profile information - profile rating (1 point everytime a client marks one of your items as collected) - my posted items - post new item

### Tags
Furniture - Clothing - Kitchen - Garden - Sports/Games - Electronics - Family - Books/Music/Films - Pet Supplies - Reform Supplies - Other (default)

### Extra Features
- Customized alerts for new posted items (tag, keywords, location...)
- Weather advice when posting ('It's going to rain, better to wait until Thursday!')
- Search bar for items by keywords
- Adapt the web app into a mobile app (automatic location, access to the device camera)
- Implement dark mode

## How to run the app

Clone or Download the repository
```
$ git clone git@github.com:jarasmar/Second_Life.git
```
Install all dependencies:
```
$ bundle install
```
Set up the databases:
```
$ rails db:create
$ rails db:migrate
```
Start the server:
```
$ rails start
```
Visit http://localhost:5000/

## Heroku App
https://second-life-app.herokuapp.com/

