#import "_SRCameraRoll.h"

typedef NS_ENUM(NSInteger, CameraRollStateType) {
    CameraRollStateTypeActive,
    CameraRollStateTypeFinished,
};

extern const NSString *CameraRollAPIStateActive;
extern const NSString *CameraRollAPIStateFinished;

@interface SRCameraRoll : _SRCameraRoll {}

+ (CameraRollStateType)cameraRollStateTypeForAPIState:(NSString *)state;

@end
