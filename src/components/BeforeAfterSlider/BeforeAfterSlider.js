import React from 'react';


const {PropTypes} = React;

export default class BeforeAfterSlider extends React.Component {

  static propTypes = {
    beforeSrc: PropTypes.string.isRequired,
    afterSrc: PropTypes.string.isRequired,
    styles: PropTypes.object,
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
      (e.clientX -
      this.container.offsetLeft) /
      this.container.clientWidth) * 100;
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
