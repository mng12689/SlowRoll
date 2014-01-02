#import "_SRCameraRoll.h"

typedef NS_ENUM(NSInteger, CameraRollStateType) {
    CameraRollStateTypeActive,
    CameraRollStateTypeFinished,
};

extern NSString* const CameraRollAPIStateActive;
extern NSString* const CameraRollAPIStateFinished;

@interface SRCameraRoll : _SRCameraRoll {}

+ (CameraRollStateType)cameraRollStateTypeForAPIState:(NSString *)state;

@end
