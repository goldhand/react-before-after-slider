Webpack-HZSkeleton
==================

boilerplate for static projects



Getting started
---------------

Install dependencies


    $ npm install


Start the dev server


    $ npm start



Project structure
-----------------

The main app folder is `./src/`

Inside the `./src/` directory is the `./src/components/` directory for components

`./webpack.babel.config.js` will look for the `./src/main.js` file when building

`./src/less` contains project-wide styles



Commands
--------

To make build a new component using with boilerplate run:


    $ npm run mkcomponent ComponentName

this will create a new component dir in `./src/components/` and add component.js,
component.less and package.json files.
