#!/bin/sh
usage="$(basename "$0") <component_name> [-t templatename] [-h] -- creates a new react component

where
    -h  show this help text
    -t  template"

APP_NAME=$1
OPTIND=1
if [ "$COMPONENTS_DIR" == "" ]; then
    COMPONENTS_DIR='./src/components';
fi;
if [[ $APP_NAME != \-* ]]; then
  OPTIND=2
fi;

while getopts ":t:h" opt; do
  case $opt in
    h)
      echo "$usage" >&2
      exit
      ;;
    t)
      TEMPLATE=$OPTARG
      echo "Using $OPTARG template\n" >&2
      ;;
    :)
      echo "Need a valid template\n" >&2
      echo "$usage" >&2
      ;;
    \?)
      printf "Invalid option -%s\n" "$OPTARG" >&2
      echo "$usage" >&2
      exit 1
      ;;
  esac
done

if [[ $APP_NAME == \-* ]] || [[ ! $APP_NAME ]]; then
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

read -d '' REDUX_COMPONENT_FILE <<- EOF
import React from 'react';
import './$APP_NAME.less';


const {PropTypes} = React;

export default class $APP_NAME extends React.Component {

  static propTypes = {
  };

  static contextTypes = {
    store: PropTypes.object,
  };
  componentDidMount() {
    this.unsubscribe = this.context.store.subscribe(() => {
      this.forceUpdate();
    });
  };
  componentWillUnmount() {
    this.unsubscribe();
  };

  render = () => {
    const {store} = this.context,
      state = store.getState();

    return (

    );
  };
}
EOF


read -d '' REACT_COMPONENT_FILE <<- EOF
import React from 'react';
import './$APP_NAME.less';


const {PropTypes} = React;

export default class $APP_NAME extends React.Component {

  static propTypes = {
  };

  render = () => {
    return (

    );
  };
}
EOF

main() {
    mkdir "$COMPONENTS_DIR/$APP_NAME";
    echo "$PACKAGE_FILE" >> "$COMPONENTS_DIR/$APP_NAME/package.json";
    echo "$STYLE_FILE" >> "$COMPONENTS_DIR/$APP_NAME/$APP_NAME.less";
    if [ "$TEMPLATE" == "" ]; then
      echo "$REACT_COMPONENT_FILE" >> "$COMPONENTS_DIR/$APP_NAME/$APP_NAME.js";
    fi
    if [ "$TEMPLATE" == "redux" ]; then
      echo "$REDUX_COMPONENT_FILE" >> "$COMPONENTS_DIR/$APP_NAME/$APP_NAME.js";
    fi
}

if [ "$APP_NAME" != "" ]; then
    main;
fi;
