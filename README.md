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

    $ npm run mkcomponent ComponentName -- [-t redux]

or

    $ npm run mkcomponentredux ComponentName

this will create a new component dir in `./src/components/` and add component.js,
component.less and package.json files.

You can change the default new component boilerplate by editing `./bin/mkComponent.sh`
there are two templates in that file, a plain react component and a redux react component


Deployment
----------

To use the development deployment commands edit `package.json` to reflect the projects development server and path to the releases directory. Add the keys `devServer` and `devServerPath` like so:

    "devServer": "mercury.hzdesign.com",
    "devServerPath": "/srv/http/webpack-hzskeleton.mercury.hzdesign.com/releases/",

make sure the folder exists on the server and run

    $ npm run deploydev

to deploy to the development server

to undo the last deployment run

    $ npm run undodeploydev

