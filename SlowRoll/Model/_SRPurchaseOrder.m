// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SRPurchaseOrder.m instead.

#import "_SRPurchaseOrder.h"

const struct SRPurchaseOrderAttributes SRPurchaseOrderAttributes = {
	.printType = @"printType",
	.state = @"state",
	.userID = @"userID",
};

const struct SRPurchaseOrderRelationships SRPurchaseOrderRelationships = {
	.cameraRoll = @"cameraRoll",
};

const struct SRPurchaseOrderFetchedProperties SRPurchaseOrderFetchedProperties = {
};

@implementation SRPurchaseOrderID
@end

@implementation _SRPurchaseOrder

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SRPurchaseOrder" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SRPurchaseOrder";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SRPurchaseOrder" inManagedObjectContext:moc_];
}

- (SRPurchaseOrderID*)objectID {
	return (SRPurchaseOrderID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"userIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"userID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic printType;






@dynamic state;






@dynamic userID;



- (int64_t)userIDValue {
	NSNumber *result = [self userID];
	return [result longLongValue];
}

- (void)setUserIDValue:(int64_t)value_ {
	[self setUserID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveUserIDValue {
	NSNumber *result = [self primitiveUserID];
	return [result longLongValue];
}

- (void)setPrimitiveUserIDValue:(int64_t)value_ {
	[self setPrimitiveUserID:[NSNumber numberWithLongLong:value_]];
}





@dynamic cameraRoll;

	






@end
