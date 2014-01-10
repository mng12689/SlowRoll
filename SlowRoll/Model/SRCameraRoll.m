#import "SRCameraRoll.h"

NSString* const CameraRollAPIStateActive = @"active";
NSString* const CameraRollAPIStateFinished = @"finished";

NSString* const CameraRollAPIPrintTypeColor = @"color";
NSString* const CameraRollAPIPrintTypeBlackAndWhite = @"black_and_white";

NSString* const errorDomain = @"com.slowroll.cameraRoll";

static NSDateFormatter *dateFormatter;

@interface SRCameraRoll ()

// Private interface goes here.

@end


@implementation SRCameraRoll

- (void)setState:(NSString *)state
{
    [self willChangeValueForKey:@"state"];
    [self setPrimitiveValue:state forKey:@"state"];
    [self didChangeValueForKey:@"state"];
    
    CameraRollStateType stateType = [SRCameraRoll cameraRollStateTypeForAPIState:self.state];
    NSInteger sortPrecedence = [SRCameraRoll sortPrecedenceForCameraRollStateType:stateType];
    [self willChangeValueForKey:@"stateSortPrecedence"];
    [self setPrimitiveValue:@(sortPrecedence) forKey:@"stateSortPrecedence"];
    [self didChangeValueForKey:@"stateSortPrecedence"];
}

+ (NSInteger)sortPrecedenceForCameraRollStateType:(CameraRollStateType)cameraRollStateType
{
    switch (cameraRollStateType) {
        case CameraRollStateTypeActive: return 0;
        case CameraRollStateTypeFinished: return 2;
    }
}

+ (CameraRollStateType)cameraRollStateTypeForAPIState:(NSString *)state
{
    if ([state isEqualToString:CameraRollAPIStateActive]) {
        return CameraRollStateTypeActive;
    } else if ([state isEqualToString:CameraRollAPIStateFinished]) {
        return CameraRollStateTypeFinished;
    }
    return 0;
}

#pragma mark - validation
- (BOOL)isValid:(NSError **)error
{
    NSMutableArray *missingFieldNames = [NSMutableArray array];
    if (!self.name.length) {
        [missingFieldNames addObject:@"\"name\""];
    }
    if (!self.printType.length) {
        [missingFieldNames addObject:@"\"print type\""];
    }
    if (!self.maxPhotos) {
        [missingFieldNames addObject:@"\"roll size\""];
    }
    
    if (missingFieldNames.count) {
        NSString *errorMessage = @"Missing required field(s):\n";
        for (NSInteger index = 0; index < missingFieldNames.count; index++) {
            errorMessage = [errorMessage stringByAppendingString:missingFieldNames[index]];
            if (index+1 < missingFieldNames.count) {
                errorMessage = [errorMessage stringByAppendingString:@", "];
            }
        }
        *error = [NSError errorWithDomain:errorDomain code:CameraRollValidationErrorCodeMissingRequiredFields userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
    }
    
    return *error == nil;
}

#pragma mark - defaults
+ (NSString *)defaultRollName
{
    dateFormatter = [NSDateFormatter new];
    NSString *formatString = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setDateFormat:formatString];
    
    NSDate *now = [NSDate date];
    NSString *nowString = [dateFormatter stringFromDate:now];
    return [NSString stringWithFormat:@"SlowRoll-%@", nowString];
}

@end
