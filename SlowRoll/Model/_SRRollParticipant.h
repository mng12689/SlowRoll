// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SRRollParticipant.h instead.

#import <CoreData/CoreData.h>


extern const struct SRRollParticipantAttributes {
	__unsafe_unretained NSString *displayName;
	__unsafe_unretained NSString *maxPhotos;
	__unsafe_unretained NSString *participantID;
	__unsafe_unretained NSString *rollID;
	__unsafe_unretained NSString *unusedPhotos;
	__unsafe_unretained NSString *userID;
} SRRollParticipantAttributes;

extern const struct SRRollParticipantRelationships {
	__unsafe_unretained NSString *cameraRoll;
} SRRollParticipantRelationships;

extern const struct SRRollParticipantFetchedProperties {
} SRRollParticipantFetchedProperties;

@class SRCameraRoll;








@interface SRRollParticipantID : NSManagedObjectID {}
@end

@interface _SRRollParticipant : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SRRollParticipantID*)objectID;





@property (nonatomic, strong) NSString* displayName;



//- (BOOL)validateDisplayName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* maxPhotos;



@property int64_t maxPhotosValue;
- (int64_t)maxPhotosValue;
- (void)setMaxPhotosValue:(int64_t)value_;

//- (BOOL)validateMaxPhotos:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* participantID;



@property int64_t participantIDValue;
- (int64_t)participantIDValue;
- (void)setParticipantIDValue:(int64_t)value_;

//- (BOOL)validateParticipantID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* rollID;



@property int64_t rollIDValue;
- (int64_t)rollIDValue;
- (void)setRollIDValue:(int64_t)value_;

//- (BOOL)validateRollID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* unusedPhotos;



@property int64_t unusedPhotosValue;
- (int64_t)unusedPhotosValue;
- (void)setUnusedPhotosValue:(int64_t)value_;

//- (BOOL)validateUnusedPhotos:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* userID;



@property int64_t userIDValue;
- (int64_t)userIDValue;
- (void)setUserIDValue:(int64_t)value_;

//- (BOOL)validateUserID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) SRCameraRoll *cameraRoll;

//- (BOOL)validateCameraRoll:(id*)value_ error:(NSError**)error_;





@end

@interface _SRRollParticipant (CoreDataGeneratedAccessors)

@end

@interface _SRRollParticipant (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDisplayName;
- (void)setPrimitiveDisplayName:(NSString*)value;




- (NSNumber*)primitiveMaxPhotos;
- (void)setPrimitiveMaxPhotos:(NSNumber*)value;

- (int64_t)primitiveMaxPhotosValue;
- (void)setPrimitiveMaxPhotosValue:(int64_t)value_;




- (NSNumber*)primitiveParticipantID;
- (void)setPrimitiveParticipantID:(NSNumber*)value;

- (int64_t)primitiveParticipantIDValue;
- (void)setPrimitiveParticipantIDValue:(int64_t)value_;




- (NSNumber*)primitiveRollID;
- (void)setPrimitiveRollID:(NSNumber*)value;

- (int64_t)primitiveRollIDValue;
- (void)setPrimitiveRollIDValue:(int64_t)value_;




- (NSNumber*)primitiveUnusedPhotos;
- (void)setPrimitiveUnusedPhotos:(NSNumber*)value;

- (int64_t)primitiveUnusedPhotosValue;
- (void)setPrimitiveUnusedPhotosValue:(int64_t)value_;




- (NSNumber*)primitiveUserID;
- (void)setPrimitiveUserID:(NSNumber*)value;

- (int64_t)primitiveUserIDValue;
- (void)setPrimitiveUserIDValue:(int64_t)value_;





- (SRCameraRoll*)primitiveCameraRoll;
- (void)setPrimitiveCameraRoll:(SRCameraRoll*)value;


@end
