#import "SRCameraRoll.h"

NSString* const CameraRollAPIStateActive = @"active";
NSString* const CameraRollAPIStateFinished = @"finished";

NSString* const CameraRollAPIPrintTypeColor = @"color";
NSString* const CameraRollAPIPrintTypeBlackAndWhite = @"black_and_white";

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
- (BOOL)isValid
{
    return self.name.length && self.printType.length && self.maxPhotos;
}

#pragma mark - defaults
+ (NSString *)defaultRollName
{
    NSDate *now = [NSDate date];
    return [NSString stringWithFormat:@"SlowRoll-%@", now];
}

@end
