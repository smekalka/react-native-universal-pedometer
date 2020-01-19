#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface BMDPedometer : RCTEventEmitter<RCTBridgeModule>
@property (nonatomic, readonly) CMPedometer *pedometer;
@end
