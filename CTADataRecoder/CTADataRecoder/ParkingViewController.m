//
//  ParkingViewController.m
//  CTADataRecoder
//
//  Created by Eddie Koranek on 7/23/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import "ParkingViewController.h"
#import "stop.h"

@interface ParkingViewController ()

@property (nonatomic, weak)IBOutlet UILabel *latitude;
@property (nonatomic, weak)IBOutlet UILabel *longitude;
@property (nonatomic, weak)IBOutlet UISegmentedControl *directionOffTrail;
@property (nonatomic, weak)IBOutlet UILabel *parkingSpots;
@property (nonatomic, weak)IBOutlet UIStepper *adjustAmount;
@property (nonatomic, retain)IBOutlet CLLocationManager *locationManager;

@end

@implementation ParkingViewController {
    
    double lat;
    double lon;
    bool da;
  //  CLLocationManager *locationManager;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _locationManager = [[CLLocationManager alloc] init];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [_locationManager startUpdatingLocation];
    
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    
    if (currentLocation != nil) {
        _longitude.text = [NSString stringWithFormat:@"%.12f", currentLocation.coordinate.longitude];
        _latitude.text = [NSString stringWithFormat:@"%.12f", currentLocation.coordinate.latitude];
        
        lat = currentLocation.coordinate.latitude;
        lon = currentLocation.coordinate.longitude;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(id)sender {
    
    double PS;
    
    PS = _adjustAmount.value;
    
    char *DOT;
    if (_directionOffTrail.selectedSegmentIndex == 0) {
        DOT = "N";
    } else if (_directionOffTrail.selectedSegmentIndex == 1) {
        DOT = "E";
    } else if (_directionOffTrail.selectedSegmentIndex == 2) {
        DOT = "S";
    } else if (_directionOffTrail.selectedSegmentIndex == 3) {
        DOT = "W";
    }
    
    stop *parking = [[stop alloc] initWithType:@"Parking" lat:&(lat) lon:&(lon) DOT: DOT picnicTables:nil parkingSpots: &PS handicapAccessible:nil dogAccessible:nil];
    parking.saveStop;

    
    
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)countParkingSpots:(id)sender {
    int amount = _adjustAmount.value;
    _parkingSpots.text = [NSString stringWithFormat:@"%@: %i", @"Parking Spots", amount];    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
