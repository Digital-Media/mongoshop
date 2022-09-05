# hyp3ue1_t2

## Install Docker and create a MongoDB Atlas Account

Install docker containers for MongoDB and the Mongo-Express Webinterface. See [Get Github-Repo](https://github.com/Digital-Media/mongoshop/blob/main/INSTALL.md#get-repo) and [Docker INSTALL](https://github.com/Digital-Media/mongoshop/blob/main/INSTALL.md#docker) for that.

Create a cloud account for MongoDB Atlas. See [Cloud INSTALL](https://github.com/Digital-Media/mongoshop/blob/main/INSTALL.md#cloud) for that.
Make yourself familiar with MongoDB Atlas, especially with `Database`, `Atlas Search`, `Browse Collections`. Look around and **don't accidentially delete data**, you will need later on. 
Have a look at the data sets with MongoDB Charts.
- Go to MongoDB Charts.
- Add the Data Source shipwrecks.
- Add geospatial heatmap Chart based on coordinates and feature_type to your Dashboard.
- Zoom in.
- Play with other datasets and possibilities.
- Upload this and two additional charts as screenshots in fullscreen mode to Moodle. The data sets and the chart types have to be different.
- Game Developers read about [Strategy Game with Unity and MongoDB](https://www.mongodb.com/developer/languages/csharp/designing-strategy-develop-game-unity-mongodb/)
- Game Developers read about [Space Shooter with Unity and MongoDB Realm](https://www.mongodb.com/developer/products/realm/building-space-shooter-game-syncs-unity-mongodb-realm/>)
# hyp3ue2_t2

## Working with Documents

- Connect to MongoDB Atlas.
- Click `Database` and then `Browse Collections`.

Never use capped collections or time series.

- Click `Create Database` and add database `onlineshop` and a first collection `user`.
- To add more collections hover over database `onlineshop` and click the plus sign next to it.
- Click on `INSERT DOCUMENT` to add documents to a collection.
- Add user with optional phone numbers, product with optional floor, orders with billing address, delivery address, order_items and payment_details to the data model.

Change the ER data model of [onlineshop](https://github.com/Digital-Media/fhooe-web-dock/blob/main/src/onlineshop.sql) to a document based model.
Consider to use sub-documents, where they are useful. Use Arrays, if they are the better choice.
Add more indexes to collection product for keys that are relevant for queries. Add a fulltext index to collection product.

!! Use `"date_registered": { "$toDate": "2014-07-08T10:43:33.522Z" }` dates if you use JSON-Editor `{}`.

!! Use data type `Object` for sub-documents.

# hyp3ue3_t2

Finish [hyp2ue4_t2](#hyp3ue2_t2).

# hyp3ue4_t2

## Fulltext Search with MongoDB Atlas

See [MongoDB Atlas Search Documentation](https://www.mongodb.com/docs/atlas/atlas-search/) to see the whole documentation.

Have a look at the MongoDB Atlas Search Example [Restaurant Page](https://www.atlassearchrestaurants.com/) and
the accompaning [Explain Video](https://www.mongodb.com/developer/products/atlas/atlas-search-demo-restaurant-app/)
Work with the [MongoDB Atlas Search Tester UI](https://www.mongodb.com/docs/atlas/atlas-search/search-ui/#std-label-atlas-search-query-ui)

Copy commands you write to a file with an appropriate name and extension .js to upload it in Moodle.
Write comment lines with `//` and number the examples (`// 1` and so on) to document what the query is about.
Use the Visual Editor for your first attempts and the JSON Editor to adapt the examples. 

### Working with the mflix-dataset

- Create another index on mflix-movies with an appropriate name.

Do not use a mapping with `"dynamic": true` as shown below, but specify the columns `plot`, `genres`,  `title`, `fullplot` and `directors` explicitly.
Here you can find more about [defining field mappings](https://www.mongodb.com/docs/atlas/atlas-search/define-field-mappings/).
You can find examples [HERE](https://www.mongodb.com/docs/atlas/atlas-search/define-field-mappings/#std-label-index-config-example).
```
{
  "mappings": {
    "dynamic": true
  }
}
```
- Copy the query (`// 1`) to your .js file.

### Working with the shipwrecks dataset

See [GeoPoint Documentation](https://www.mongodb.com/docs/atlas/atlas-search/near/#std-label-near-ref) for more information.
Maybe review the documentation for defining field mappings again.

- Create an index on shipwrecks.
- Type **visible** into the search field.
- Press the Search button.
- Press "Edit Query Syntax"
- Copy the original query to your .js file.
- Edit the query in a way, that the search is done for documents containing **visible** **AND/OR** **submerged**
- Copy the new query to your .js file.

- Change one entry of shipwrecks and change it in a way, that geo queries are possible.
- Use the existing `array` `coordinates` and convert it to a `location` `Object` with `type: "Point"` that includes the `array` `coordinates`.
- Then convert 4 more documents in the same way.
- Build a query to find a shipwreck based on coordinates.

A documentation for all geospatial queries you can find [HERE](https://www.mongodb.com/docs/manual/geospatial-queries/)
Build more examples according to the [Search Tutorials](https://www.mongodb.com/docs/atlas/atlas-search/tutorials/) for additional points.

## hyp3ue5_t2

Finish [hyp3ue4_t2](#hyp3ue4_t2).

## hyp3ue6_t2

### Working with Schema Validation in MongoDB

In certain collections we'd like to have required columns. 
For example a product should have a name, a price, a sku and some more fields that all documents have in common.

To bring a partial schema and central input validation (constraints) to mongodb documents you can use [Schema Validation](https://www.mongodb.com/docs/manual/core/schema-validation/).

- Start Docker Desktop.
- Open Powershell or other terminal.
- Connect to mongodb client
```
docker exec -it mongo /bin/bash -c mongo
```
- `use test`
- Submit the provided `students` example.
- Insert 2 documents into `students`.
- Find out, how to insert integer values.
- 1st document without key street
- 2nd document with key street. 
- Force validation errors for each key and document them.

- Create a schema validation for a table `product` with keys `"name": string`, `"price": double`, `"sku": int` and `"active": boolean`.
- During insert use 2 additional keys that are not required and validated.
- Insert 3 documents with distinct additional keys.
- Force an error on the boolean data type and document it.

## hyp3ue7_t2

### Working with the sample.supplies.sales data set

- Connect to MongoDB Atlas
- Go to Aggregation Tab
- Add $match stage to reduce the documents to storeLocation "New York"
- Add a $count stage to find out how many items where sold in New York.
- Store the result in a collection with a $out stage.
- Export pipeline to Phyton with import and driver syntax.
- Copy result to a file with an appropriate name and extension .js.

- Go to Aggregation Tab
- Add $match stage to reduce the documents to storeLocation "New York"
- Add a $unwind stage to unwind items for a $group stage
- Add a group stage and build sum of the multiply of items.price and items.quantity
- Store the result in a collection with a $out stage.
- Export pipeline code to Phyton with import and driver syntax.
- Append the copied result to the file created above.
- Upload file to Moodle.

- Go to the sample_restaurants.restaurants data set
- Group the result bei borough and count the number of restaurants:
- Reduce the result depending on a search term and a geolocation Point with a free chosen distance.
- to get additional points

## hyp3ue8_t2

Adapt the Example CRUD to work with a collection `countries`. Use the Class `Countries` as a starting point and add routes to `/public/index.php`.
See [MongoDB PHP Tutorials](https://www.mongodb.com/docs/php-library/current/tutorial/) for details.
Use `db.users.drop();`, `db.countries.drop();` or `db.orders.drop();` to delete collections  from the commandline during testing.

## hyp3ue9_t2

Finish [hyp3ue8_t2](#hyp3ue8_t2).

## hyp3ue10_t2

Adapt the Example Doctrine to work with a collection `orders`. Use the Class `MyCart` as a starting point and add routes to `/public/index.php`.
See [Doctrine Tutorials](https://www.doctrine-project.org/projects/doctrine-orm/en/current/tutorials/getting-started.html) for details.
Use `db.users.drop();`, `db.countries.drop();` or `db.orders.drop();` to delete collections from the commandline during testing.
