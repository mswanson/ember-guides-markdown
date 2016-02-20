# Import Script

This is a POC for importing all the Ember guide markdown files into a couchDB database. The idea is to use a script like this to "deploy" version/translations of the Ember Guides into production while at the same time allowing us to build the guides site as an Ember app that simply access this data.

## Caveats:

1. This is just a POC, I haven't done much testing and it is pretty fragile. If the structure of the `page.yml` file or the `data/pages` directory change it will break.
2. I am completely ignoring the translated files. The goal was to show that we could import the markdown files based on `pages.yml` so for now if it's not there it doesn't get imported.
