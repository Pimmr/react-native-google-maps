#import "RCTGoogleMapsManager.h"
#import "RCTGoogleMaps.h"
#import "UIView+React.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
@import GoogleMaps;

@interface RCTGoogleMapsManager() <GMSMapViewDelegate>

@end

@implementation RCTGoogleMapsManager

RCT_EXPORT_MODULE();

RCT_EXPORT_VIEW_PROPERTY(myLocationEnabled, BOOL);
RCT_EXPORT_VIEW_PROPERTY(onDrag, RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onDragBegin, RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onDragEnd, RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onCameraIdle, RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onCameraWillMove, RCTBubblingEventBlock);
RCT_REMAP_VIEW_PROPERTY(compassButtonEnabled, settings.compassButton, BOOL)
RCT_REMAP_VIEW_PROPERTY(myLocationButtonEnabled, settings.myLocationButton, BOOL)
RCT_REMAP_VIEW_PROPERTY(scrollGesturesEnabled, settings.scrollGestures, BOOL)
RCT_REMAP_VIEW_PROPERTY(zoomGesturesEnabled, settings.zoomGestures, BOOL)
RCT_REMAP_VIEW_PROPERTY(tiltGesturesEnabled, settings.tiltGestures, BOOL)
RCT_REMAP_VIEW_PROPERTY(rotateGesturesEnabled, settings.rotateGestures, BOOL)

RCT_CUSTOM_VIEW_PROPERTY(region, NSDictionary, RCTGoogleMaps)
{
  if (json) {
    float latitude = [RCTConvert float:json[@"latitude"]];
    float longitude = [RCTConvert float:json[@"longitude"]];
    float zoom = [RCTConvert float:json[@"zoom"]];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: latitude
                                                            longitude: longitude
                                                                 zoom: zoom];
    view.camera = camera;
  }
}

RCT_CUSTOM_VIEW_PROPERTY(annotations, NSArray, RCTGoogleMaps)
{
  if (json) {
    [view clear];
    for (NSDictionary *annotation in json) {
      float latitude = [RCTConvert float:annotation[@"latitude"]];
      float longitude = [RCTConvert float:annotation[@"longitude"]];
      NSString *title = [RCTConvert NSString:annotation[@"title"]];
      CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latitude, longitude);
      GMSMarker *marker = [GMSMarker markerWithPosition:position];
      marker.title = title;
      marker.map = view;
    }
  }
}

- (UIView *)view
{
  RCTGoogleMaps* map = [[RCTGoogleMaps alloc] init];
  map.delegate = self;
  return map;
}

- (void) mapView:(RCTGoogleMaps *)mapView didBeginDraggingMarker:(GMSMarker *)marker
{
  if (mapView.onDragBegin) {
    mapView.onDragBegin(@{
      @"latitude": @(marker.position.latitude),
      @"longitude": @(marker.position.longitude)
    });
  }
}

- (void) mapView:(RCTGoogleMaps *)mapView didEndDraggingMarker:(GMSMarker *)marker
{
  if (mapView.onDragEnd) {
    mapView.onDragEnd(@{
      @"latitude": @(marker.position.latitude),
      @"longitude": @(marker.position.longitude)
    });
  }
}

- (void) mapView:(RCTGoogleMaps *)mapView didDragMarker:(GMSMarker *)marker
{
  if (mapView.onDrag) {
    mapView.onDrag(@{
      @"latitude": @(marker.position.latitude),
      @"longitude": @(marker.position.longitude)
    });
  }
}

- (void) mapView:(RCTGoogleMaps *) mapView willMove:(BOOL) gesture
{
  if (mapView.onCameraWillMove) {
    mapView.onCameraWillMove(@{
      @"gesture": @(gesture)
    });
  }
}

- (void) mapView:(RCTGoogleMaps *)mapView idleAtCameraPosition:(GMSCameraPosition *)position
{
  if (mapView.onCameraIdle) {
    mapView.onCameraIdle(@{
      @"latitude": @(position.target.latitude),
      @"longitude": @(position.target.longitude),
      @"zoom": @(position.zoom)
    });
  }
}

@end
