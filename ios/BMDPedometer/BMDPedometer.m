#import "BMDPedometer.h"
#import "SOStepDetector.h"

#import <CoreMotion/CoreMotion.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>

@interface BMDPedometer ()
@property (nonatomic, readonly) CMPedometer *pedometer;
@end


@implementation BMDPedometer

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents{

    return @[@"pedometerDataDidUpdate", @"pedometerWasStep"];
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXPORT_METHOD(isStepCountingAvailable:(RCTResponseSenderBlock)callback) {
    callback(@[[NSNull null], @([CMPedometer isStepCountingAvailable])]);
}

RCT_EXPORT_METHOD(isFloorCountingAvailable:(RCTResponseSenderBlock) callback) {
    callback(@[[NSNull null], @([CMPedometer isFloorCountingAvailable])]);
}

RCT_EXPORT_METHOD(isDistanceAvailable:(RCTResponseSenderBlock) callback) {
    callback(@[[NSNull null], @([CMPedometer isDistanceAvailable])]);
}

RCT_EXPORT_METHOD(queryPedometerDataBetweenDates:(NSDate *)startDate endDate:(NSDate *)endDate handler:(RCTResponseSenderBlock)handler) {
    [self.pedometer queryPedometerDataFromDate:startDate
                                        toDate:endDate
                                   withHandler:^(CMPedometerData *pedometerData, NSError *error) {
                                       handler(@[error.description?:[NSNull null], [self dictionaryFromPedometerData:pedometerData]]);
                                   }];
}

RCT_EXPORT_METHOD(startPedometerUpdatesFromDate:(NSDate *)date) {
    [self.pedometer startPedometerUpdatesFromDate:date?:[NSDate date]
                                      withHandler:^(CMPedometerData *pedometerData, NSError *error) {
                                          if (pedometerData) {
                                              [self sendEventWithName:@"pedometerDataDidUpdate" body:[self dictionaryFromPedometerData:pedometerData]];
                                          }
                                      }];
}

- (NSDictionary *)dictionaryFromPedometerData:(CMPedometerData *)data {

    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ";
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    });
    
    return @{
             @"startDate": [formatter stringFromDate:data.startDate]?:[NSNull null],
             @"endDate": [formatter stringFromDate:data.endDate]?:[NSNull null],
             @"numberOfSteps": data.numberOfSteps?:[NSNull null],
             @"distance": data.distance?:[NSNull null],
             @"floorsAscended": data.floorsAscended?:[NSNull null],
             @"floorsDescended": data.floorsDescended?:[NSNull null],
    };
}

RCT_EXPORT_METHOD(startStepsDetection) {
    [[SOStepDetector sharedInstance] startDetectionWithUpdateBlock:^(NSError *error) {
        if(error) {
            return;
        } else {
            [self sendEventWithName:@"pedometerWasStep" body:@true];
        }
    }];
}

RCT_EXPORT_METHOD(stopPedometerUpdates) {
    [self.pedometer stopPedometerUpdates];
    [[SOStepDetector sharedInstance]  stopDetection];
}

#pragma mark - Private

- (instancetype)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }

    _pedometer = [[CMPedometer alloc]init];

    return self;
}


@end
