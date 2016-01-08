#import "RCTGoogleMaps.h"
#import "RCTLog.h"

@implementation RCTGoogleMaps

const int DEFAULT_MY_LOCATION_ZOOM = 14;

- (instancetype)init
{
  if ((self = [super init])) {
    [self addObserver:self
           forKeyPath:@"myLocation"
              options:NSKeyValueObservingOptionNew
              context:NULL];
    self.firstCameraUpdateForMyLocation = NO;
  }

  return self;
}

- (void)dealloc {
  [self removeObserver:self
            forKeyPath:@"myLocation"
               context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if (self.myLocationEnabled && self.firstCameraUpdateForMyLocation) {
    self.firstCameraUpdateForMyLocation = YES;
    CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
    self.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                 zoom:DEFAULT_MY_LOCATION_ZOOM];
  }
}

- (void)insertReactSubview:(UIView *)view atIndex:(NSInteger)atIndex
{
  RCTLogError(@"Google maps cannot have any subviews");
  return;
}

- (void)removeReactSubview:(UIView *)subview
{
  RCTLogError(@"Google maps cannot have any subviews");
  return;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  [CATransaction begin];
  [CATransaction setAnimationDuration:0];

  for (UIView *subview in self.subviews)
  {
    subview.frame = self.bounds;
  }

  [CATransaction commit];
}


@end
