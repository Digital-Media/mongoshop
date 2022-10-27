db = db.getSiblingDB('onlineshop');
db.dropDatabase();
db = db.getSiblingDB('onlineshop');
/*
Copy the JSON from ATLAS Cloud, if you want to test your code there first.

    {
        "first_name": "Martin",
        "last_name": "Harrer",
        "password": "geheim",
        "date_registered": $toDate("2014-07-08T10:43:33.522Z")
    }

Use the database icon in the right upper corner of PHPStorm to add a connection
to the local MongoDB Docker container. --> https://github.com/Digital-Media/fhooe-mongo-dock
Download the MongoDB Driver
No password and user needed in the given Configuration
Surround the JSON with db.<collection_name>.insertOne( JSON );
*/
db.user.insertOne({
    "_id": ObjectId("540d8cdc6803fa790e4257eb"),
    "first_name": "shop",
    "last_name": "user1",
    "password": "geheim",
    "date_registered": $toDate("2014-07-08T10:43:33.522Z")
});