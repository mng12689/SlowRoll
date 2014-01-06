#import "_SRCameraRoll.h"

typedef NS_ENUM(NSInteger, CameraRollStateType) {
    CameraRollStateTypeActive,
    CameraRollStateTypeFinished,
};

extern NSString* const CameraRollAPIStateActive;
extern NSString* const CameraRollAPIStateFinished;

typedef NS_ENUM(NSInteger, CameraRollPrintType) {
    CameraRollStateTypeColor,
    CameraRollStateTypeBlackAndWhite,
};

extern NSString* const CameraRollAPIPrintTypeColor;
extern NSString* const CameraRollAPIPrintTypeBlackAndWhite;

@interface SRCameraRoll : _SRCameraRoll {}

+ (CameraRollStateType)cameraRollStateTypeForAPIState:(NSString *)state;

- (BOOL)isValid;

+ (NSString *)defaultRollName;

@end
