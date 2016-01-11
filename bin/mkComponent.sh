#!/bin/sh

# makes a new react component
APP_NAME=$1;
if [ "$COMPONENTS_DIR" == "" ]; then
    COMPONENTS_DIR='./src/components';
fi;
if [ "$APP_NAME" == "" ]; then
    echo "App Name? ";
    read APP_NAME;
fi;


read -d '' PACKAGE_FILE <<- EOF
{
  "name": "$APP_NAME",
  "version": "0.0.0",
  "private": true,
  "main": "./$APP_NAME.js"
}
EOF

read -d '' STYLE_FILE <<- EOF
@import '../base.less';
EOF

read -d '' COMPONENT_FILE <<- EOF
import React from 'react';
import './$APP_NAME.less';


const {PropTypes} = React;

export default class $APP_NAME extends React.Component {

  static contextTypes = {
    store: PropTypes.object,
  }
  componentDidMount() {
    this.unsubscribe = this.context.store.subscribe(() => {
      this.forceUpdate();
    });
  }
  componentWillUnmount() {
    this.unsubscribe();
  }

  render = () => {
    const {store} = this.context,
      state = store.getState();

    return (

    )
  }
}
EOF

main() {
    mkdir "$COMPONENTS_DIR/$APP_NAME";
    echo "$PACKAGE_FILE" >> "$COMPONENTS_DIR/$APP_NAME/package.json";
    echo "$STYLE_FILE" >> "$COMPONENTS_DIR/$APP_NAME/$APP_NAME.less";
    echo "$COMPONENT_FILE" >> "$COMPONENTS_DIR/$APP_NAME/$APP_NAME.js";
}

if [ "$APP_NAME" != "" ]; then
    main;
fi;
