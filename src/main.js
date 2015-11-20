import React from 'react';
import ReactDOM from 'react-dom';

import App from './components/App';


class Main extends React.Component {

  render() {

    return (
      <main>
        <App title="Hello World" description="Oh haaaayy" />
      </main>
    );
  }
}

ReactDOM.render(
  <Main />,
  document.getElementById('main')
);
