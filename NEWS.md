# observatoire 0.9.2

* Improve the plot of the budget by theme
* Make all the projects visible on the clusters of points on the map
* Make the "Filter" button more visible

# observatoire 0.9.1

* Add startup screen to hide app initialization glitches to the users

# observatoire 0.9.0

* Display graphs with budget by theme and year in project selection view

# observatoire 0.8.0

* Users can now filter projects on projects selection view
* If target criteria correspond to no single project an empty map with an informative
message is drawn

# observatoire 0.7.3

* Consolidate topic data i.e. rederive topic_ binary columns from topic character column.

# observatoire 0.7.2

* Project JS graph only displayed in project view

# observatoire 0.7.1

* Input values update logic now works with {shinyWidgets} inputs

# observatoire 0.7.0

* Input values on project selection view are read from the data and not predefined.

# observatoire 0.6.0

* Plot the distribution of the budget for one project

# observatoire 0.5.5

* Make the translation of some FR caracteristics homogeneous with the vocabulary used in PSCH
  
# observatoire 0.5.4

* Increase the visibility of the cantons influenced 

# observatoire 0.5.3

* Use a 2 columns layout adapted to desktop devices (not mobile devices) in the main view

# observatoire 0.5.2

* Delete not pretty blue box around checkboxes
* Set a 2 columns layout in the first view

# observatoire 0.5.1

* Start to create inputs on the main view that correspond to the design system of PSCH

# observatoire 0.5.0

* Display real project data in project selection map
* Use marker clusters to display project with the same coordinates

# observatoire 0.4.1

* Fix missing cities and zip codes in raw data
* Fix a warning in the calculation of centroids
* Start to implement a custom design system on the main panel

# observatoire 0.4.0

* Translate the values in status / risk factors/ topic in DE and FR
* Show them in the projects cards

# observatoire 0.3.0

* Add the description of the projects in DE and FR
* Add a 'more details' link that sends the user to the PSCH website

# observatoire 0.2.4

* Fix the language switch in the corner
* Open the page of the project manager in a new tab

# observatoire 0.2.3

* Fix the regex in the topics and risk factors to correspond to the regex used to separe elements in the raw data

# observatoire 0.2.2

* Adapt the color of the main panel to the color of the map

# observatoire 0.2.1

* Use a PSCH flavicon

# observatoire 0.2.0

* Add lines between the project and the cantons influenced

# observatoire 0.1.3

* Make the project card responsive

# observatoire 0.1.2

* Include the language switch in both views 
* Give the possibility to click on the map to go back to the general view

# observatoire 0.1.1

* Add the project cards css to the custom.css used by the app
* Add an orange arrow to go back to the main view
* Remove the iframe and include the projects cards directly

# observatoire 0.1.0

* Enable the user to see all projects cards

# observatoire 0.0.10

* Enable the user to switch between views (all projects vs one project)

# observatoire 0.0.9

* Add a function to create a map for one project
* Include the example HTML for the projects

# observatoire 0.0.8

* Add translation system scaffold
* Add project selection UI

# observatoire 0.0.7

* Adjust map zoom depending on screen width
* Add a first draft for the projects cards

# observatoire 0.0.6

* Add more functions to prepare the data used by the app
* Start to begin unit test to ensure the projects data will be usable by the app
* Update the vignette to prepare the data used by the app

# observatoire 0.0.5

* Include leaflet map bound to Swiss territory
* Improve map layout
* Update architecture schema with user story

# observatoire 0.0.4

* Add the detection of the canton in the raw data

# observatoire 0.0.3

* Add the geocoding to the raw data

# observatoire 0.0.2

* Start the function to prepare the data

# observatoire 0.0.1

* Add interactive {leaflet} map
