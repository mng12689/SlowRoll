// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SRCameraRoll.h instead.

#import <CoreData/CoreData.h>


extern const struct SRCameraRollAttributes {
	__unsafe_unretained NSString *maxPhotos;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *rollID;
	__unsafe_unretained NSString *unusedPhotos;
} SRCameraRollAttributes;

extern const struct SRCameraRollRelationships {
	__unsafe_unretained NSString *participants;
	__unsafe_unretained NSString *purchaseOrders;
} SRCameraRollRelationships;

extern const struct SRCameraRollFetchedProperties {
} SRCameraRollFetchedProperties;

@class SRRollParticipant;
@class SRPurchaseOrder;






@interface SRCameraRollID : NSManagedObjectID {}
@end

@interface _SRCameraRoll : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SRCameraRollID*)objectID;





@property (nonatomic, strong) NSNumber* maxPhotos;



@property int64_t maxPhotosValue;
- (int64_t)maxPhotosValue;
- (void)setMaxPhotosValue:(int64_t)value_;

//- (BOOL)validateMaxPhotos:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





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





@property (nonatomic, strong) NSSet *participants;

- (NSMutableSet*)participantsSet;




@property (nonatomic, strong) NSSet *purchaseOrders;

- (NSMutableSet*)purchaseOrdersSet;





@end

@interface _SRCameraRoll (CoreDataGeneratedAccessors)

- (void)addParticipants:(NSSet*)value_;
- (void)removeParticipants:(NSSet*)value_;
- (void)addParticipantsObject:(SRRollParticipant*)value_;
- (void)removeParticipantsObject:(SRRollParticipant*)value_;

- (void)addPurchaseOrders:(NSSet*)value_;
- (void)removePurchaseOrders:(NSSet*)value_;
- (void)addPurchaseOrdersObject:(SRPurchaseOrder*)value_;
- (void)removePurchaseOrdersObject:(SRPurchaseOrder*)value_;

@end

@interface _SRCameraRoll (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveMaxPhotos;
- (void)setPrimitiveMaxPhotos:(NSNumber*)value;

- (int64_t)primitiveMaxPhotosValue;
- (void)setPrimitiveMaxPhotosValue:(int64_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveRollID;
- (void)setPrimitiveRollID:(NSNumber*)value;

- (int64_t)primitiveRollIDValue;
- (void)setPrimitiveRollIDValue:(int64_t)value_;




- (NSNumber*)primitiveUnusedPhotos;
- (void)setPrimitiveUnusedPhotos:(NSNumber*)value;

- (int64_t)primitiveUnusedPhotosValue;
- (void)setPrimitiveUnusedPhotosValue:(int64_t)value_;





- (NSMutableSet*)primitiveParticipants;
- (void)setPrimitiveParticipants:(NSMutableSet*)value;



- (NSMutableSet*)primitivePurchaseOrders;
- (void)setPrimitivePurchaseOrders:(NSMutableSet*)value;


@end
