// Collection cart befüllen
db.cart.drop();
db.cart.insert([
    {
        "_id": ObjectId("540da8836803fa7a0e4257ee"),
        "pid": "540da8836803fa7a0e4257ee",
        "session_id": "540d8e6d6803fa290c4257eb",
        "product_name": "My favorite Book",
        "price": 20.00,
        "quantity": 2,
    },
    {
        "_id": ObjectId("740dd8836803fa7a0e4257ee"),
        "pid": "740dd8836803fa7a0e4257ee",
        "session_id": "540d8e6d6803fa290c4257eb",
        "product_name": "My favorite Car",
        "price": 19000.00,
        "quantity": 1,
    },
    {
        "_id": ObjectId("640df8836803fa7a0e4257ee"),
        "pid": "640df8836803fa7a0e4257ee",
        "session_id": "640d8e6d6803fa290c4257eb",
        "product_name": "My favorite Album",
        "price": 19.00,
        "quantity": 3,
    },
]);
db.cart.find().pretty();
