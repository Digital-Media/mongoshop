// examples how to submit the solution
// The JSON itself must be valid and can be tested in different ways
// 1. use a file with extension .js and assign the JSON to a js variable,
// then syntax highlighting works within PHPStorm
// user
let user1 =
    {
        "first_name": "Martin",
        "last_name": "Harrer",
        "password": "geheim",
        "date_registered": $toData("2014-07-08T10:43:33.522Z")
    }
// 2. give collection name in a comment above the simple JSON
// test for valid syntax in MongoDB Atlas and copy it to this file
// PHPStorm highlights some syntax errors, but they do not matter for this exercise
// _id must not be given on MongoDB Atlas cloud
// user
{
    "first_name": "Martin",
    "last_name": "Harrer",
    "password": "geheim",
    "date_registered": $toData("2014-07-08T10:43:33.522Z")
}
// 3. test it in commandline
db.user.insert({
    "_id": ObjectId("540d8cdc6803fa790e4257eb"),
    "first_name": "shop",
    "last_name": "user1",
    "nick_name": "shopuser1",
    "email": "shopuser1@onlineshop.at",
    "password": "geheim",
    "role": "user",
    "date_registered": ISODate("2014-07-08T10:43:33.522Z")
});
// example2
// variante 1
db.getCollection("payment").insert({
    "_id": ObjectId("540d99066803fa7b0e4257ec"),
    "users_id": "540d8e6d6803fa290c4257eb",
    "paymenttype": "credit card",
    "payment_details": {
        "holder": "shopuser1",
        "card_number": "1234-1234-1234-1234",
        "valid_until": "04-2016",
        "bank_name": "Doubtful Credits Institut"
    }
});
// variante 2
let payment1 =
    {
        "_id": ObjectId("540d99066803fa7b0e4257ec"),
        "users_id": "540d8e6d6803fa290c4257eb",
        "paymenttype": "credit card",
        "payment_details": {
            "holder": "shopuser1",
            "card_number": "1234-1234-1234-1234",
            "valid_until": "04-2016",
            "bank_name": "Doubtful Credits Institut"
        }
    };
// variante 3
// _id is generated automatically by MongoDB Atlas
// payment
{
    "users_id": "540d8e6d6803fa290c4257eb",
    "paymenttype": "credit card",
    "payment_details": {
        "holder": "shopuser1",
        "card_number": "1234-1234-1234-1234",
        "valid_until": "04-2016",
        "bank_name": "Doubtful Credits Institut"
    }
}