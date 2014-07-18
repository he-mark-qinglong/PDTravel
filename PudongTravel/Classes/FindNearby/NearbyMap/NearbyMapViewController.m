//
//  NearbyMapViewController.m
//  PudongTravel
//
//  Created by mark on 14-3-28.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "NearbyMapViewController.h"
#import "UIView+FitVersions.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface NearbyMapViewController ()

@property (nonatomic, strong) IBOutlet UITextField *bdSearchTextField;
@property (nonatomic, strong) IBOutlet UIButton *bdSearchBtn;
@property (nonatomic, strong) IBOutlet UIView *controllSubView;
@property (nonatomic, strong) IBOutlet UIView *controllBottom;

@end

@implementation NearbyMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.bdMapSearch.delegate = self;

    [self fitController];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (IBAction)bdSearchBtnPress:(id)sender
{
    
}

- (void)fitController
{
    if (IOSVersion70)
    {
        [self.controllSubView FitViewOffsetY];
        [self.controllSubView FitViewHeight];
        [self.mapView FitViewHeight];
        [self.controllBottom FitViewOffsetYSubtract];
    }
}

- (NSString*)getMyBundlePath1:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE;
	if ( libBundle && filename ){
		NSString * s = [[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		return s;
	}
	return nil ;
}

//返回需要的routeAnnotation View
- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(BDMRouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
	switch (routeAnnotation.annotationType) {
        case BDMPositionOriginPoint:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"BDMPositionOriginPoint"];
            if(view == nil)
            {
                BMKPinAnnotationView *annotataionView = [[BMKPinAnnotationView alloc] initWithAnnotation:routeAnnotation reuseIdentifier:@"BDMPositionOriginPoint"];
                annotataionView.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/bnavi_icon_location_fixed.png"]];
                annotataionView.canShowCallout = NO;
            }
            view.annotation = routeAnnotation;
            break;
        }
		case BDMPositionStartPoint:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"BDMPositionStartPoint"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"BDMPositionStartPoint"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
            break;
		}
			
		case BDMPositionEndPoint:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"BDMPositionEndPoint"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"BDMPositionEndPoint"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
            break;
		}
		case BDMPositionBusPoint:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"BDMPositionBusPoint"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"BDMPositionBusPoint"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
            break;
		}
		case BDMPositionMetroPoint:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"BDMPositionMetroPoint"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"BDMPositionMetroPoint"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
            break;
		}
        case BDMPositionDrivingPoint:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"BDMPositionDrivingPoint"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"BDMPositionDrivingPoint"];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
			view.annotation = routeAnnotation;
            break;
        }
            
		default:
			break;
	}
	
	return view;
}


#pragma mark - BMKMapViewDelegate methods
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    //self.mapView.centerCoordinate = userLocation.coordinate;
}


- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
	return nil;
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BDMRouteAnnotation class]])
        return [self getRouteAnnotationView:mapView viewForAnnotation:(BDMRouteAnnotation*)annotation];
    return nil;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
}

- (void)onGetDrivingRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
    
}

#pragma mark - BMKSearchDelegate
- (void)onGetPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
{
    
}

- (void)onGetTransitRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
    
}

- (void)GetDrivingRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
    
}


- (void)onGetWalkingRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
    
}

- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
    
}

- (void)onGetSuggestionResult:(BMKSuggestionResult*)result errorCode:(int)error
{
    
}
- (void)onGetBusDetailResult:(BMKBusLineResult*)busLineResult errorCode:(int)error
{
    
}
- (void)onGetShareUrl:(NSString*) url withType:(BMK_SHARE_URL_TYPE) urlType errorCode:(int)error
{
    
}
@end
