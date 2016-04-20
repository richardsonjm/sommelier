# Sommelier

Sommelier is a tool for organizing and search wine data.
Data is primarily source from **Wine.com** (https://www.wine.com).
Live site can be found **here** (https://sommelr.herokuapp.com).

## Wines

* Users can update and delete existing wine products, as well as create new ones in our local database.
* Users can search for wine products.

## Dashboard

* Users can load and reload fresh data from the wine.com API.
* When loading/reloading data from the wine.com API, application does not delete or overwrite products that were added directly to our local database by a user.
* When loading/reloading data from the wine.com API, it will delete/overwrite products from the wine.com API even if a user has modified the information on those products.
