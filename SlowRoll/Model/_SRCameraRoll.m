// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SRCameraRoll.m instead.

#import "_SRCameraRoll.h"

const struct SRCameraRollAttributes SRCameraRollAttributes = {
	.maxPhotos = @"maxPhotos",
	.name = @"name",
	.rollID = @"rollID",
	.state = @"state",
	.unusedPhotos = @"unusedPhotos",
};

const struct SRCameraRollRelationships SRCameraRollRelationships = {
	.participants = @"participants",
	.purchaseOrders = @"purchaseOrders",
};

const struct SRCameraRollFetchedProperties SRCameraRollFetchedProperties = {
};

@implementation SRCameraRollID
@end

@implementation _SRCameraRoll

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SRCameraRoll" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SRCameraRoll";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SRCameraRoll" inManagedObjectContext:moc_];
}

- (SRCameraRollID*)objectID {
	return (SRCameraRollID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"maxPhotosValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"maxPhotos"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"rollIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rollID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"unusedPhotosValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"unusedPhotos"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic maxPhotos;



- (int64_t)maxPhotosValue {
	NSNumber *result = [self maxPhotos];
	return [result longLongValue];
}

- (void)setMaxPhotosValue:(int64_t)value_ {
	[self setMaxPhotos:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveMaxPhotosValue {
	NSNumber *result = [self primitiveMaxPhotos];
	return [result longLongValue];
}

- (void)setPrimitiveMaxPhotosValue:(int64_t)value_ {
	[self setPrimitiveMaxPhotos:[NSNumber numberWithLongLong:value_]];
}





@dynamic name;






@dynamic rollID;



- (int64_t)rollIDValue {
	NSNumber *result = [self rollID];
	return [result longLongValue];
}

- (void)setRollIDValue:(int64_t)value_ {
	[self setRollID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveRollIDValue {
	NSNumber *result = [self primitiveRollID];
	return [result longLongValue];
}

- (void)setPrimitiveRollIDValue:(int64_t)value_ {
	[self setPrimitiveRollID:[NSNumber numberWithLongLong:value_]];
}





@dynamic state;






@dynamic unusedPhotos;



- (int64_t)unusedPhotosValue {
	NSNumber *result = [self unusedPhotos];
	return [result longLongValue];
}

- (void)setUnusedPhotosValue:(int64_t)value_ {
	[self setUnusedPhotos:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveUnusedPhotosValue {
	NSNumber *result = [self primitiveUnusedPhotos];
	return [result longLongValue];
}

- (void)setPrimitiveUnusedPhotosValue:(int64_t)value_ {
	[self setPrimitiveUnusedPhotos:[NSNumber numberWithLongLong:value_]];
}





@dynamic participants;

	
- (NSMutableSet*)participantsSet {
	[self willAccessValueForKey:@"participants"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"participants"];
  
	[self didAccessValueForKey:@"participants"];
	return result;
}
	

@dynamic purchaseOrders;

	
- (NSMutableSet*)purchaseOrdersSet {
	[self willAccessValueForKey:@"purchaseOrders"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"purchaseOrders"];
  
	[self didAccessValueForKey:@"purchaseOrders"];
	return result;
}
	






@end
