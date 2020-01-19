#import "BMDPedometer.h"
#import <CoreMotion/CoreMotion.h>
#import <React/RCTLog.h>

#define NullErr [NSNull null]

@interface BMDPedometer ()
@property (nonatomic, readwrite) CMPedometer *pedometer;
@end


@implementation BMDPedometer

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXPORT_MODULE()

- (NSArray<NSString *> *)supportedEvents{
    return @[@"pedometerDataDidUpdate"];
}

RCT_EXPORT_METHOD(isStepCountingAvailable:(RCTResponseSenderBlock) callback) {
    callback(@[NullErr, @([CMPedometer isStepCountingAvailable])]);
}

RCT_EXPORT_METHOD(isFloorCountingAvailable:(RCTResponseSenderBlock) callback) {
    callback(@[NullErr, @([CMPedometer isFloorCountingAvailable])]);
}

RCT_EXPORT_METHOD(isDistanceAvailable:(RCTResponseSenderBlock) callback) {
    callback(@[NullErr, @([CMPedometer isDistanceAvailable])]);
}

RCT_EXPORT_METHOD(isCadenceAvailable: (RCTResponseSenderBlock) callback) {
    callback(@[NullErr, @([CMPedometer isCadenceAvailable])]);
}

RCT_EXPORT_METHOD(isPaceAvailable: (RCTResponseSenderBlock) callback) {
    callback(@[NullErr, @([CMPedometer isPaceAvailable])]);
}

RCT_EXPORT_METHOD(queryPedometerDataBetweenDates:(NSDate *)startDate endDate:(NSDate *)endDate handler:(RCTResponseSenderBlock)handler) {
    [self.pedometer queryPedometerDataFromDate:startDate
                                        toDate:endDate
                                   withHandler:^(CMPedometerData *pedometerData, NSError *error) {
                                       handler(@[error.description?:NullErr, [self dictionaryFromPedometerData:pedometerData]]);
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
             @"startDate": [formatter stringFromDate:data.startDate]?:NullErr,
             @"endDate": [formatter stringFromDate:data.endDate]?:NullErr,
             @"numberOfSteps": data.numberOfSteps?:NullErr,
             @"distance": data.distance?:NullErr,
             @"floorsAscended": data.floorsAscended?:NullErr,
             @"floorsDescended": data.floorsDescended?:NullErr,
             @"currentPace": data.currentPace?:NullErr,
             @"currentCadence": data.currentCadence?:NullErr,
    };
}

RCT_EXPORT_METHOD(stopPedometerUpdates) {
    [self.pedometer stopPedometerUpdates];
}

#pragma mark - Private

- (instancetype)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }

    _pedometer = [CMPedometer new];

    return self;
}

@end
