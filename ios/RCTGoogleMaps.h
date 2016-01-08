#import "RCTView.h"
@import GoogleMaps;

@interface RCTGoogleMaps : GMSMapView
  @property BOOL firstCameraUpdateForMyLocation;
  @property (nonatomic, copy) RCTBubblingEventBlock onDrag;
  @property (nonatomic, copy) RCTBubblingEventBlock onDragBegin;
  @property (nonatomic, copy) RCTBubblingEventBlock onDragEnd;
  @property (nonatomic, copy) RCTBubblingEventBlock onCameraIdle;
  @property (nonatomic, copy) RCTBubblingEventBlock onCameraWillMove;
@end
