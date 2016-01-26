import React from 'react';
import './App.less';
import imgCat from '../../img/cat.gif';
import BeforeAfterSlider from '../BeforeAfterSlider';


const range = (start, end, next, arr) => {
  if (! arr) arr = [], next = start;
  if ( arr.length > (end - start)) return arr;
  arr = [
    ...arr,
    next,
  ];
  next += 1;
  return range(start, end, next, arr);
};

const {PropTypes} = React;

export default class App extends React.Component {

  static propTypes = {
  };

  gridContainerStyles = () => ({
    display: 'flex',
    flexFlow: 'row wrap',
  });
  gridChildStyles = () => ({
    flex: '50%',
  });

  render() {

    return (
      <div>
        <div
          style={this.gridContainerStyles()}
        >
          {range(1, 10).map(c =>
            <div
              style={this.gridChildStyles()}
              key={`grid-child-${c}`}
            >
              <BeforeAfterSlider
                beforeSrc='https://www-standardmeat-com-develop.s3.amazonaws.com/static/standardmeat/standardmeat/components/CompareImageSlider/images/before.jpg'
                afterSrc='https://www-standardmeat-com-develop.s3.amazonaws.com/static/standardmeat/standardmeat/components/CompareImageSlider/images/after.jpg'
                styles={{}} />
            </div>
          )
        }
        </div>
      </div>
    );
  }
}

