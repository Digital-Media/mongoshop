// Collection cart befüllen
db.countries.drop();
db.countries.insert([
    {
        "_id": ObjectId("540da8836803fa7a0e4257ee"),
        "country": "Homeland",
        "isocode": "HL",
    },
    {
        "_id": ObjectId("740dd8836803fa7a0e4257ee"),
        "country": "Tomorrow Land",
        "isocode": "TL",
    },
    {
        "_id": ObjectId("640df8836803fa7a0e4257ee"),
        "country": "Favorite Destination",
        "isocode": "FD",
    },
]);
db.countries.find().pretty();
