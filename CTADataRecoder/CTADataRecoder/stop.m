//
//  stop.m
//  CTADataRecoder
//
//  Created by Johnmark Beaty on 9/20/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import "stop.h"

@implementation stop {
    
    @private
        NSString *type;
        double lat;
        double lon;
        char DOT;
        int picnicTables;
        double parkingSpots;
        bool handicapAccessible;
        bool dogAccessible;

}



-(id)initWithType:(NSString *)Type lat:(double *)Lat lon:(double *)Lon DOT:(char *)dot picnicTables:(int *)PicnicTables parkingSpots:(double *)ParkingSpots handicapAccessible:(bool *)HandicapAccessible dogAccessible:(bool *)DogAccessible {
    self = [super init];
    
    if(self) {
        type = Type;
        lat = *Lat;
        lon = *Lon;
        DOT = *dot;
        picnicTables = PicnicTables;
        parkingSpots = *ParkingSpots;
        handicapAccessible = HandicapAccessible;
        dogAccessible = DogAccessible;
        
    }
    return self;
}

-(void)saveStop {
    
    NSString *docsDir;
    NSArray *dirPaths;
   // NSString *databasePath;
   // sqlite3 *stopDB;
    //Get Document directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    //Build path to database
    _databasePath = [[NSString alloc]
                    initWithString: [docsDir stringByAppendingPathComponent:
                                     @"stops.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_stopDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS STOPS (ID INTEGER PRIMARY KEY AUTOINCREMENT, TYPE TEXT, LAT DOUBLE, LON DOUBLE, DOT CHAR, PICNICTABLES INT, PARKINGSPOTS INT, HANDICAPACCESSIBLE BOOL, DOGACCESSIBLE BOOL)";
            
            if (sqlite3_exec(_stopDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            sqlite3_close(_stopDB);
        } else {
            NSLog(@"Failed to open/create database");
        }
    }

    
    sqlite3_stmt *statement;
    const char *dbPath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbPath, &_stopDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO STOPS (type, lat, lon, DOT, picnicTables, parkingSpots, handicapAccessible, dogAccessible) VALUES (\"%@\", \"%f\", \"%f\", \"%c\", \"%d\", \"%f\", \"%d\", \"%d\")",
#warning Check that String Fromat Specifier matches database 
                               type, lat, lon, DOT, picnicTables, parkingSpots, handicapAccessible, dogAccessible];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_stopDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"STOP ADDED");
        }else{
            NSLog(@"FAILED TO ADD STOP");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_stopDB);

    }
}


@end
