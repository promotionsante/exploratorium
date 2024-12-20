# exploratorium 1.0.1

- Freeze highchart.js version number to avoid breaking changes in the library to
  affect the app.

# exploratorium 1.0.0

- Data is now extracted directly from the Promotion Digitale Database before being
  fed to the etl and saved in inst/.
- Clean {fusen} artifacts: useless examples etc...
- Remove toy datasets. Those were hard to maintain up to date. Use either app data are inline reprexes.

# exploratorium 0.12.0

- Fix project manager broken links.

# exploratoritum 0.11.0

- Moving from Gitlab to Github

# exploratoritum 0.10.18

- Update architecture schema to reflect real time project cards rendering
- Make the ditinction between project and app translation data in data preparation vignette

# exploratoirum 0.10.17

- Only display PSCH share in yearly cumulative budget graph.

# exploratoirum 0.10.16

- Use {pak} instead of {remotes} in CI to avoid silent errors when
  a package fails to install.

# exploratorium 0.10.15

- Correct DE translation of project completion section in project cards

# exploratorium 0.10.14

- Shorten intro text
- Make section titles more visible in selection and project pages
- Add a completion bar tracking project completion percentage based on
  the postion of the current date between project start and end date.
- Use specific CRAN snapshot in all ci jobs via a CI specific .Rprofile.

# exploratorium 0.10.13

- Update CI environement to match new dev env.

# exploratorium 0.10.12

- Fix bug app closing at startup after removing filtering button.

# exploratorium 0.10.11

- Make checkbox borders more visible

# exploratorium 0.10.10

- Increase the font size everywhere

# exploratorium 0.10.9

- Change the localization of SERO
- Change the short titles used to print the projects

# exploratorium 0.10.8

- Standardize the term used for the responsible organization
- Standardize certain titles and subtitles to match the terminology used by PSCH

# exploratorium 0.10.7

- Add a UAT version of the app

# exploratorium 0.10.6

- Fix the title of the app

# exploratorium 0.10.5

- Remove the flags from the architecture schema

# exploratorium 0.10.4

- Update the final documentation (general overview and other articles)

# exploratorium 0.10.3

- Rename into {exploratorium}

# exploratorium 0.10.2

- Make the right panel visible after the change of the language in the description page

# exploratorium 0.10.1

- Add the 2 functions to create budget plot in pkgdown

# exploratorium 0.10.0

- Use a lineplot with a cumulative curve for the evolution of the budget by year

# exploratorium 0.9.4

- Slider values persist when changing language

# exploratorium 0.9.3

- JS graph is properly updated (does not disappeared) when changing language on project
  focus view

# exploratorium 0.9.2

- Improve the plot of the budget by theme
- Make all the projects visible on the clusters of points on the map
- Make the "Filter" button more visible

# exploratorium 0.9.1

- Add startup screen to hide app initialization glitches to the users

# exploratorium 0.9.0

- Display graphs with budget by theme and year in project selection view

# exploratorium 0.8.0

- Users can now filter projects on projects selection view
- If target criteria correspond to no single project an empty map with an informative
  message is drawn

# exploratorium 0.7.3

- Consolidate topic data i.e. rederive topic\_ binary columns from topic character column.

# exploratorium 0.7.2

- Project JS graph only displayed in project view

# exploratorium 0.7.1

- Input values update logic now works with {shinyWidgets} inputs

# exploratorium 0.7.0

- Input values on project selection view are read from the data and not predefined.

# exploratorium 0.6.0

- Plot the distribution of the budget for one project

# exploratorium 0.5.5

- Make the translation of some FR caracteristics homogeneous with the vocabulary used in PSCH

# exploratorium 0.5.4

- Increase the visibility of the cantons influenced

# exploratorium 0.5.3

- Use a 2 columns layout adapted to desktop devices (not mobile devices) in the main view

# exploratorium 0.5.2

- Delete not pretty blue box around checkboxes
- Set a 2 columns layout in the first view

# exploratorium 0.5.1

- Start to create inputs on the main view that correspond to the design system of PSCH

# exploratorium 0.5.0

- Display real project data in project selection map
- Use marker clusters to display project with the same coordinates

# exploratorium 0.4.1

- Fix missing cities and zip codes in raw data
- Fix a warning in the calculation of centroids
- Start to implement a custom design system on the main panel

# exploratorium 0.4.0

- Translate the values in status / risk factors/ topic in DE and FR
- Show them in the projects cards

# exploratorium 0.3.0

- Add the description of the projects in DE and FR
- Add a 'more details' link that sends the user to the PSCH website

# exploratorium 0.2.4

- Fix the language switch in the corner
- Open the page of the project manager in a new tab

# exploratorium 0.2.3

- Fix the regex in the topics and risk factors to correspond to the regex used to separe elements in the raw data

# exploratorium 0.2.2

- Adapt the color of the main panel to the color of the map

# exploratorium 0.2.1

- Use a PSCH flavicon

# exploratorium 0.2.0

- Add lines between the project and the cantons influenced

# exploratorium 0.1.3

- Make the project card responsive

# exploratorium 0.1.2

- Include the language switch in both views
- Give the possibility to click on the map to go back to the general view

# exploratorium 0.1.1

- Add the project cards css to the custom.css used by the app
- Add an orange arrow to go back to the main view
- Remove the iframe and include the projects cards directly

# exploratorium 0.1.0

- Enable the user to see all projects cards

# exploratorium 0.0.10

- Enable the user to switch between views (all projects vs one project)

# exploratorium 0.0.9

- Add a function to create a map for one project
- Include the example HTML for the projects

# exploratorium 0.0.8

- Add translation system scaffold
- Add project selection UI

# exploratorium 0.0.7

- Adjust map zoom depending on screen width
- Add a first draft for the projects cards

# exploratorium 0.0.6

- Add more functions to prepare the data used by the app
- Start to begin unit test to ensure the projects data will be usable by the app
- Update the vignette to prepare the data used by the app

# exploratorium 0.0.5

- Include leaflet map bound to Swiss territory
- Improve map layout
- Update architecture schema with user story

# exploratorium 0.0.4

- Add the detection of the canton in the raw data

# exploratorium 0.0.3

- Add the geocoding to the raw data

# exploratorium 0.0.2

- Start the function to prepare the data

# exploratorium 0.0.1

- Add interactive {leaflet} map
