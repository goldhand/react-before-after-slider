import React from 'react';
import './App.less';
import imgCat from '../../img/cat.gif';


const {PropTypes} = React;

export default class App extends React.Component {

  static propTypes = {
    title: PropTypes.string,
    description: PropTypes.string,
  }

  render() {

    return (
      <div>
        <h1>{this.props.title}</h1>
        <img src={imgCat} />
        <p>{this.props.description}</p>
      </div>
    );
  }
}

