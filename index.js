import React from 'react-native';

const {
  requireNativeComponent,
  PropTypes,
  View,
} = React;

const GoogleMaps = React.createClass({
  propTypes: {
    style: View.propTypes.style,
    myLocationEnabled: PropTypes.bool,
    compassButtonEnabled: PropTypes.bool,
    myLocationButtonEnabled: PropTypes.bool,
    scrollGesturesEnabled: PropTypes.bool,
    zoomGesturesEnabled: PropTypes.bool,
    tiltGesturesEnabled: PropTypes.bool,
    rotateGesturesEnabled: PropTypes.bool,
    region: React.PropTypes.shape({
      latitude: React.PropTypes.number.isRequired,
      longitude: React.PropTypes.number.isRequired,
      zoom: React.PropTypes.number.isRequired,
    }),
    annotations: React.PropTypes.arrayOf(
      React.PropTypes.shape({
        latitude: React.PropTypes.number.isRequired,
        longitude: React.PropTypes.number.isRequired,
        title: React.PropTypes.string.isRequired,
      })
    ),
    onMarkerDrag: React.PropTypes.func,
    onMarkerDragBegin: React.PropTypes.func,
    onMarkerDragEnd: React.PropTypes.func,
    onRegionMoveEnd: React.PropTypes.func,
    onRegionMoveStart: React.PropTypes.func,
  },

  getDefaultProps() {
    return {
      myLocationEnabled: false,
      compassButtonEnabled: false,
      myLocationButtonEnabled: false,
      scrollGesturesEnabled: false,
      zoomGesturesEnabled: false,
      tiltGesturesEnabled: false,
      rotateGesturesEnabled: false,
    };
  },

  handleDrag(e) {
    if (this.props.onMarkerDrag) {
      this.props.onMarkerDrag({
        latitude: e.nativeEvent.latitude,
        longitude: e.nativeEvent.longitude,
      });
    }
  },

  handleDragBegin(e) {
    if (this.props.onMarkerDragBegin) {
      this.props.onMarkerDragBegin({
        latitude: e.nativeEvent.latitude,
        longitude: e.nativeEvent.longitude,
      });
    }
  },

  handleDragEnd(e) {
    if (this.props.onMarkerDragEnd) {
      this.props.onMarkerDragEnd({
        latitude: e.nativeEvent.latitude,
        longitude: e.nativeEvent.longitude,
      });
    }
  },

  handleCameraIdle(e) {
    if (this.props.onRegionMoveEnd) {
      this.props.onRegionMoveEnd({
        latitude: e.nativeEvent.latitude,
        longitude: e.nativeEvent.longitude,
        zoom: e.nativeEvent.zoom,
      });
    }
  },

  handleCameraWillMove() {
    if (this.props.onRegionMoveStart) {
      this.props.onRegionMoveStart();
    }
  },

  render() {
    return (
      <RCTGoogleMaps
        {...this.props}
        onDrag={this.handleDrag}
        onDragBegin={this.handleDragBegin}
        onDragEnd={this.handleDragEnd}
        onCameraIdle={this.handleCameraIdle}
        onCameraWillMove={this.handleCameraWillMove}
      />
    );
  },
});

const RCTGoogleMaps = requireNativeComponent(
  'RCTGoogleMaps',
  GoogleMaps,
  {
    nativeOnly: {
      onDrag: true,
      onDragBegin: true,
      onDragEnd: true,
      onCameraIdle: true,
      onCameraWillMove: true,
    },
  }
);

export default GoogleMaps;
