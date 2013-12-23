//
//  SRNetworkingProtocol.h
//  SlowRoll
//
//  Created by Michael Ng on 12/22/13.
//  Copyright (c) 2013 SlowRoll. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SRNetworkingProtocol <NSObject>

@required
+ (NSDictionary *)JSONRepresentation;

@end
