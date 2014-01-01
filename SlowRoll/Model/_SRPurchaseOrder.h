// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SRPurchaseOrder.h instead.

#import <CoreData/CoreData.h>


extern const struct SRPurchaseOrderAttributes {
	__unsafe_unretained NSString *printType;
	__unsafe_unretained NSString *state;
	__unsafe_unretained NSString *userID;
} SRPurchaseOrderAttributes;

extern const struct SRPurchaseOrderRelationships {
	__unsafe_unretained NSString *cameraRoll;
} SRPurchaseOrderRelationships;

extern const struct SRPurchaseOrderFetchedProperties {
} SRPurchaseOrderFetchedProperties;

@class SRCameraRoll;





@interface SRPurchaseOrderID : NSManagedObjectID {}
@end

@interface _SRPurchaseOrder : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SRPurchaseOrderID*)objectID;





@property (nonatomic, strong) NSString* printType;



//- (BOOL)validatePrintType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* state;



//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* userID;



@property int64_t userIDValue;
- (int64_t)userIDValue;
- (void)setUserIDValue:(int64_t)value_;

//- (BOOL)validateUserID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) SRCameraRoll *cameraRoll;

//- (BOOL)validateCameraRoll:(id*)value_ error:(NSError**)error_;





@end

@interface _SRPurchaseOrder (CoreDataGeneratedAccessors)

@end

@interface _SRPurchaseOrder (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitivePrintType;
- (void)setPrimitivePrintType:(NSString*)value;




- (NSString*)primitiveState;
- (void)setPrimitiveState:(NSString*)value;




- (NSNumber*)primitiveUserID;
- (void)setPrimitiveUserID:(NSNumber*)value;

- (int64_t)primitiveUserIDValue;
- (void)setPrimitiveUserIDValue:(int64_t)value_;





- (SRCameraRoll*)primitiveCameraRoll;
- (void)setPrimitiveCameraRoll:(SRCameraRoll*)value;


@end
