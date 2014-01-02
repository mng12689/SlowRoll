#import "SRCameraRoll.h"


@interface SRCameraRoll ()

// Private interface goes here.

@end


@implementation SRCameraRoll

- (NSNumber *)stateSortPrecedence
{
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

@end
