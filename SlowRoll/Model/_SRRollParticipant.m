// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SRRollParticipant.m instead.

#import "_SRRollParticipant.h"

const struct SRRollParticipantAttributes SRRollParticipantAttributes = {
	.displayName = @"displayName",
	.maxPhotos = @"maxPhotos",
	.participantID = @"participantID",
	.rollID = @"rollID",
	.unusedPhotos = @"unusedPhotos",
	.userID = @"userID",
};

const struct SRRollParticipantRelationships SRRollParticipantRelationships = {
	.cameraRoll = @"cameraRoll",
};

const struct SRRollParticipantFetchedProperties SRRollParticipantFetchedProperties = {
};

@implementation SRRollParticipantID
@end

@implementation _SRRollParticipant

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SRRollParticipant" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SRRollParticipant";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SRRollParticipant" inManagedObjectContext:moc_];
}

- (SRRollParticipantID*)objectID {
	return (SRRollParticipantID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"maxPhotosValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"maxPhotos"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"participantIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"participantID"];
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
	if ([key isEqualToString:@"userIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"userID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic displayName;






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





@dynamic participantID;



- (int64_t)participantIDValue {
	NSNumber *result = [self participantID];
	return [result longLongValue];
}

- (void)setParticipantIDValue:(int64_t)value_ {
	[self setParticipantID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveParticipantIDValue {
	NSNumber *result = [self primitiveParticipantID];
	return [result longLongValue];
}

- (void)setPrimitiveParticipantIDValue:(int64_t)value_ {
	[self setPrimitiveParticipantID:[NSNumber numberWithLongLong:value_]];
}





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
