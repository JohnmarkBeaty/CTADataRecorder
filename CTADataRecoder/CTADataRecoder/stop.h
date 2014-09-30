//
//  stop.h
//  CTADataRecoder
//
//  Created by Johnmark Beaty on 9/20/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface stop : NSObject

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *stopDB;

-(id)initWithType:(NSString *)Type lat:(double *)Lat lon:(double *)Lon DOT:(char *)dot picnicTables:(int *)PicnicTables parkingSpots:(double *)ParkingSpots handicapAccessible:(bool *)HandicapAccessible dogAccessible:(bool *)DogAccessible;
-(void)saveStop;

@end
