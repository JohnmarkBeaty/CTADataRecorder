//
//  ShopsViewController.m
//  CTADataRecoder
//
//  Created by Eddie Koranek on 7/23/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import "ShopsViewController.h"
#import "stop.h"

@interface ShopsViewController ()

@property (nonatomic, weak)IBOutlet UILabel *latitude;
@property (nonatomic, weak)IBOutlet UILabel *longitude;
@property (nonatomic, weak)IBOutlet UISegmentedControl *directionOffTrail;
@property (nonatomic, weak)IBOutlet UISwitch *handicap;



@end

@implementation ShopsViewController {
    CLLocationManager *locationManager;
    double lat;
    double lon;
    bool da;
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
    locationManager = [[CLLocationManager alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
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
        lat = currentLocation.coordinate.latitude;
        lon = currentLocation.coordinate.longitude;
        
        _longitude.text = [NSString stringWithFormat:@"%.12f", currentLocation.coordinate.longitude];
        _latitude.text = [NSString stringWithFormat:@"%.12f", currentLocation.coordinate.latitude];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(id)sender {

    
    if (_handicap.on == 0)
    {
        da = false;
    } else {
        da = true;
    }
    
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
    
    stop *bathroom = [[stop alloc] initWithType:@"Bathroom" lat:&(lat) lon:&(lon) DOT: DOT picnicTables:nil parkingSpots: nil handicapAccessible:&(da) dogAccessible:nil];
    bathroom.saveStop;
    
    
    
    
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
