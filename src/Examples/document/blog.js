db = db.getSiblingDB('blog');
db.dropDatabase();
db = db.getSiblingDB('blog');
// Collection blog mit eingebetteten comments
db.embedded_blog.insert([
{
"_id": "Erster Post",
"author": "John",
"text": "Ich poste heute zum ersten Mal",
"comments": [ { "author": "Jane",
                "text": "Toller Post"
              },
              { "author": "Ann",
                "text": "Wunderbarer Post"
              },
			  { "author": "Bob",
			    "text" : "Na, so toll auch wieder nicht"
			  }
            ]
},
{
"_id" : "Noch ein Post",
"author" : "Ann",
"text" : "Schreibt mir mal was in die Kommentarzeile",
"comments" : [ { "author" : "John",
                 "text" : "Aber gern doch"
			   },
			   { "author" : "Bob",
                 "text" : "Muss das sein"
               }
             ]
}
]);

// Suche nach comments von Bob liefert auch die comments aller anderen User. 
// Es wird jeder Post, den Bob kommentiert hat geliefert
// Aussortieren erfolgt in der Applikation

db.embedded_blog.find( { "comments.author" : "Bob" }, { "comments" : 1 }).pretty();

// Normalized Schema
db.normalized_blog.insert([
{
"_id" : "Erster Post",
"author" : "John",
"text":  "Ich poste heute zum ersten Mal"
},
{
"_id" : "Noch ein Post",
"author" : "Ann",
"text" : "Schreibt mir mal was in die Kommentarzeile"
}
]);
db.normalized_comments.insert([
{
   "post_id" : "First Post",
   "author" : "Jane",
   "text" : "Toller Post"
},
{
   "post_id" : "First Post",
   "author" : "Ann",
   "text" : "Wunderbarer Post"
},
{
   "post_id" : "First Post",
   "author" : "Bob",
   "text" : "Na, so toll auch wieder nicht"
},
{
   "post_id" : "Noch ein Post",
   "author" : "John",
   "text" : "Aber gern doch"
},
{
   "post_id" : "Noch ein Post",
   "author" : "Bob",
   "text" : "Muss das sein?"
}
]);

// find() ist jetzt straight forward und liefert alle comments von Bob
db.normalized_comments.find( { "author" : "Bob" } ).pretty();

// Man kann jetzt auch andere Dinge abfragen ist nicht darauf beschränkt die comments genau in der Reihenfolge geliefert zu bekommen, in der sie in blog gespeichert wurden.
db.normalized_comments.find().sort( { "author" : 1 } ).pretty();


db.normalized_comments.find().skip(2).pretty();

db.normalized_comments.find().limit(2).pretty();