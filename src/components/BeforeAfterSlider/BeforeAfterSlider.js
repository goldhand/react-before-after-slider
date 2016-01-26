/*
 * Before-After Slider
 * Display before and after images in one space of one image.
 * When the user hovers over the image, the image is divided at that point
 * Move the cursor to the right to see the after image
 * Move the cursor to the left to see the before image
 * The parent element should define some width for this component, flexbox works well
 */

import React from 'react';


const {PropTypes} = React;

export default class BeforeAfterSlider extends React.Component {

  static propTypes = {
    beforeSrc: PropTypes.string.isRequired,
    afterSrc: PropTypes.string.isRequired,
    styles: PropTypes.object,  // any additional styles to be passed into the container
  };

  constructor(props) {
    super(props);
    this.state = this.initialState();
  }
  initialState = () => {
    return ({afterWidth: 0});
  };

  componentDidMount = () => {
    this.container.addEventListener('mousemove', (e) => {
      this.updateWidth(this.calcWidth(e));
    });
  };

  updateWidth = (width) => {
    this.setState({
      afterWidth: width,
    })
  };

  calcWidth = (e) => {
    return (
      (e.clientX -                        // cursor x axis
      this.container.offsetLeft) /        // how far left on the page is this element
      this.container.clientWidth) * 100;  // total width of the element
  };

  styles = () => {
    return {
      position: 'relative',
      maxWidth: '100%',
      maxHeight: '100%',
      ...this.props.styles,
    }
  };

  render = () => {
    return (
      <div
        style={this.styles()}
        ref={(c) => this.container = c}
      >
        <BeforeImg
          src={this.props.beforeSrc} />
        <AfterImg
          src={this.props.afterSrc}
          width={`${this.state.afterWidth}%`} />
      </div>
    );
  };
}


const BeforeImg = ({
  src,
}) => {

  const styles = {
    display: 'block',
  };

  return (
    <img
      style={styles}
      src={src} />
  );
}

const AfterImg = ({
  src,
  width,
}) => {

  const styles = {
    backgroundImage: `url('${src}')`,
    backgroundRepeat: 'no-repeat',
    backgroundSize: 'cover',
    backgroundPosition: 'top left',
    height: '100%',
    position: 'absolute',
    top: 0,
    left: 0,
    width: width,
  }

  return (
    <div
    style={styles} />
  );
}
