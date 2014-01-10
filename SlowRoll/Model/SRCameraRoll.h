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

extern NSString* const errorDomain;

typedef NS_ENUM(NSInteger, CameraRollValidationErrorCode) {
    CameraRollValidationErrorCodeMissingRequiredFields
};

@interface SRCameraRoll : _SRCameraRoll {}

+ (CameraRollStateType)cameraRollStateTypeForAPIState:(NSString *)state;

- (BOOL)isValid:(NSError **)error;

+ (NSString *)defaultRollName;

@end
