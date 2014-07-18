//
//  NearbyMapViewController.m
//  PudongTravel
//
//  Created by mark on 14-3-28.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "NearbyMapViewController.h"
#import "UIView+FitVersions.h"
#import "CommonHeader.h"
#import "GoViewController.h"
#import "NearbyData.h"
#import "FoodViewController.h"  //拿VCType的原型

#import "CustomPointAnnotation.h"
#import "CalloutAnnotationView.h"
#import "CalloutMapAnnotation.h"
#import "ScenicSpotViewController.h"

#import "implBMKSearchDelegate.h"
#import "CarPointAnnotation.h"

static const int km = 1000;

@interface NearbyMapViewController ()<MapPopViewDelegate, BMKMapViewDelegate>
{
    CalloutMapAnnotation *_calloutMapAnnotation;
    CLLocationCoordinate2D _userCoordinate;
    BOOL _getLocation;
    
    BMKMapView *_mapView;
    implBMKSearchDelegate *_implBMKSearchDelegate;
    
}
@property (nonatomic, strong) IBOutlet UITextField *bdSearchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *showListBtn;
@property (weak, nonatomic) IBOutlet UIButton *locateBtn;
@property (weak, nonatomic) IBOutlet UIButton *goBtn;


@property (nonatomic, strong) IBOutlet UIView *controllSubView;
@property (nonatomic, strong) IBOutlet UIView *controllBottom;
@property (weak, nonatomic) IBOutlet UIView *searchInputView;

@property (strong, nonatomic) NSArray *arrayToShow;

@property VCType vcType;
@end

@implementation NearbyMapViewController
@synthesize mapView = _mapView;

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"定位";  //设置标题
}

-(void)searchPlace{
    [self.bdSearchTextField resignFirstResponder];
    [self.bdMapSearch poiSearchInCity:@"上海" withKey:self.bdSearchTextField.text pageIndex:0];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self fitController];
    nvc              = [NearbyViewController new];
    
    //搜索按钮点击
    [[self.searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [self searchPlace];
     }];
    //搜索框输入完毕
    [[self.bdSearchTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit]
     subscribeNext:^(id x) {
         [self searchPlace];
     }];
    //列表展示
    [[self.showListBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [self.navigationController pushViewController:nvc animated:NO];
     }];
    //定位
    [[self.locateBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [self removeAllAnnotationAndOverlay];
         _getLocation = YES;
         [[BaiDuMapManager ShareInstrance] BDMStartUserLocationService];
     }];
    //路线查询
    [[self.goBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         GoViewController *gvc = [GoViewController new];
         gvc.mapDelegate       = self;
         [self.navigationController pushViewController:gvc animated:NO];
     }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.mapView.delegate          = self;
    _implBMKSearchDelegate         = [implBMKSearchDelegate new];
    _implBMKSearchDelegate.mapView = self.mapView;
    self.bdMapSearch.delegate      = _implBMKSearchDelegate;
    
    [[(AppDelegate *)[UIApplication sharedApplication].delegate menuController].pan setEnabled:NO];
    
    if(self.willShowUserLocation){
        [[BaiDuMapManager ShareInstrance] BDMStartUserLocationService];
        self.mapView.showsUserLocation = YES;
    }else{
        self.mapView.showsUserLocation = NO;
    }
    
    UIImage *bkgd;
    if (IOS7)
        bkgd = [UIImage imageNamed:@"top_background.png"];
    else
        bkgd = [UIImage imageNamed:@"top44.png"];
    [self.navigationController.navigationBar setBackgroundImage:bkgd
                                                  forBarMetrics:UIBarMetricsDefault];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[(AppDelegate *)[UIApplication sharedApplication].delegate menuController].pan setEnabled:YES];
    
    self.willShowUserLocation = NO;
    self.mapView.delegate     = nil;
    self.bdMapSearch.delegate = nil;
}

- (void)fitController{
    if (IOSVersion70){
        [self.controllSubView FitViewOffsetY];
        [self.controllSubView FitViewHeight];
        [self.mapView FitViewHeight];
    }
    [self.controllBottom FitViewOffsetYSubtract];
}

- (NSString*)getMyBundlePath1:(NSString *)filename{
    static  NSString *buddleName = @"mapapi.bundle";
    NSString *buddlePath =
    [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: buddleName];
	NSBundle *libBundle  = [NSBundle bundleWithPath: buddlePath];
	if ( libBundle && filename ){
		return [[libBundle resourcePath ] stringByAppendingPathComponent:filename];
	}
	return nil;
}

//返回需要的routeAnnotation View
- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview
                           viewForAnnotation:(BDMRouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    NSString *file;
	switch (routeAnnotation.annotationType) {
        case BDMPositionOriginPoint:
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"BDMPositionOriginPoint"];
            if(view == nil)
                view = [[BMKPinAnnotationView alloc]
                        initWithAnnotation:routeAnnotation
                        reuseIdentifier:@"BDMPositionOriginPoint"];
            file                = [self getMyBundlePath1:@"images/bnavi_icon_location_fixed.png"];
            break;
		case BDMPositionStartPoint:
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"BDMPositionStartPoint"];
			if (view == nil)
				view = [[BMKAnnotationView alloc] initWithAnnotation:routeAnnotation
                                                     reuseIdentifier:@"BDMPositionStartPoint"];
            file                = [self getMyBundlePath1:@"images/icon_nav_start.png"];
            view.centerOffset   = CGPointMake(0, -(view.frame.size.height * 0.5));
            break;
		case BDMPositionEndPoint:
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"BDMPositionEndPoint"];
			if (view == nil)
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation
                                                    reuseIdentifier:@"BDMPositionEndPoint"];
            file                = [self getMyBundlePath1:@"images/icon_nav_end.png"];
            view.centerOffset   = CGPointMake(0, -(view.frame.size.height * 0.5));
            break;
		case BDMPositionBusPoint:
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"BDMPositionBusPoint"];
			if (view == nil)
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation
                                                    reuseIdentifier:@"BDMPositionBusPoint"];
            break;
		case BDMPositionMetroPoint:
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"BDMPositionMetroPoint"];
			if (view == nil)
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation
                                                    reuseIdentifier:@"BDMPositionMetroPoint"];
            break;
        case BDMPositionDrivingPoint:
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"BDMPositionDrivingPoint"];
			if (view == nil)
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation
                                                    reuseIdentifier:@"BDMPositionDrivingPoint"];
			else
				[view setNeedsDisplay];
            file                = [self getMyBundlePath1:@"images/icon_nav_waypoint.png"];
            break;
		default:
			break;
	}
    if(routeAnnotation.annotationType == BDMPositionOriginPoint)
        view.canShowCallout = NO;
    else
        view.canShowCallout = YES;
	view.annotation     = routeAnnotation;
    view.image          = [UIImage imageWithContentsOfFile:file];
	return view;
}

#pragma - mark BMKMapView
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    _userCoordinate = userLocation.coordinate;
    if (_getLocation) {
        [self setMapCenter:[BaiDuMapManager ShareInstrance].currentLocation];
        _getLocation = NO;
    }
}
#pragma mark data process
-(void)loadDataFromWebWithType:(NSInteger)type{
    NSString *path = @"";
    if (self.vcType == CarPark){
        path = [getStopList copy];
        path = [path stringByAppendingString:
                [NSString stringWithFormat:@"?lat=%f&lng=%f",
                 self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude]];
    }else{
        path = [getNearDisList copy];
        path = [path stringByAppendingString:
                [NSString stringWithFormat:@"?lat=%f&lng=%f&pageNum=1&type=%d&isPush=0",
                 self.mapView.centerCoordinate.latitude,
                 self.mapView.centerCoordinate.longitude, type]];
    }
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error)
     {
         [self removeAllAnnotationAndOverlay];
         //拿数据
         if (self.vcType == CarPark){
             CarParkData *data = [CarParkData new];
             [data updateWithJsonDic:json];
             
             NSMutableArray *array = [NSMutableArray new];
             for(CarParkInfo *parkInfo in data->arrayCarParkInfo){
                 [array addObject:[parkInfo convertToNearbyOtherInfo]];
             }
             self.arrayToShow  = array;
         }else{
             NearbyOtherData *data = [NearbyOtherData new];
             [data updateWithJsonDic:json];
             self.arrayToShow  = data->arrayNearbyOtherInfo;
         }
         //添加数据到视图
         for (NearbyOtherInfo *info in self.arrayToShow){
             CustomPointAnnotation *customPA = [CustomPointAnnotation new];
             customPA.info       = info;
             customPA.coordinate = { info->lat, info->lng };
             customPA.isStopCarPopView = (self.vcType == CarPark);
             [self.mapView addAnnotation:customPA];
         }
     }];
}
-(void)showSevenPop
{
    NSString *path = [getStopViewList copy];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error)
     {
         NearbyOtherData *data = [NearbyOtherData new];
         [data updateWithJsonDic:json];
         self.arrayToShow  = data->arrayNearbyOtherInfo;
         for (NearbyOtherInfo *info in self.arrayToShow){
             CustomPointAnnotation *customPA = [CustomPointAnnotation new];
             customPA.info       = info;
             customPA.coordinate = { info->lat, info->lng };
             customPA.isStopCarPopView = NO;
             [self.mapView addAnnotation:customPA];
         }
         
     }];
}

#pragma mark - BMKMapViewDelegate
- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay{
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
	return nil;
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView
             viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BDMRouteAnnotation class]]){
        return [self getRouteAnnotationView:mapView
                          viewForAnnotation:(BDMRouteAnnotation*)annotation];
    }else if ([annotation isKindOfClass:[CustomPointAnnotation class]]) {
        CustomPointAnnotation *ann = (CustomPointAnnotation*)annotation;
        static NSString *AnnotationID = @"customAnnotation";
        BMKAnnotationView* annotationView
        = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                           reuseIdentifier:AnnotationID];
        if(ann.isStopCarPopView)
            annotationView.image = [UIImage imageWithResourceName:@"pop.png"];
        else
            annotationView.image = [UIImage imageWithResourceName:@"icon_i.png"];
        annotationView.canShowCallout = NO;
        return annotationView;
    } else if([annotation isKindOfClass:[CalloutMapAnnotation class]]){
        static NSString *AnnotationID = @"calloutview";
        CalloutMapAnnotation *ann = (CalloutMapAnnotation*)annotation;
        CalloutAnnotationView *calloutannotationview
        = [[CalloutAnnotationView alloc] initWithAnnotation:annotation
                                            reuseIdentifier:AnnotationID];
            [calloutannotationview showPopView:ann.info delegate:self
                                     isCarPark:ann.isStopCarPopView];
        return calloutannotationview;
    } else if([annotation isKindOfClass:[BMKPointAnnotation class]] ){
        static NSString *AnnotationID = @"nothing";
        BMKAnnotationView* annotationView =
        [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationID];
        annotationView.image = [UIImage imageWithResourceName:@"icon_i.png"];
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    return nil;
}
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    id <BMKAnnotation> annotation = view.annotation;
    if(annotation == nil){
        NSLog(@"nil annotations");
    }
    if (_calloutMapAnnotation != nil &&
        _calloutMapAnnotation.coordinate.latitude == annotation.coordinate.latitude &&
        _calloutMapAnnotation.coordinate.longitude == annotation.coordinate.longitude) {
        return;
    }
    if (_calloutMapAnnotation) {
        [mapView removeAnnotation:_calloutMapAnnotation];
        _calloutMapAnnotation = nil;
    }
    _calloutMapAnnotation           = [[CalloutMapAnnotation alloc] init];
    _calloutMapAnnotation.longitude = annotation.coordinate.longitude;
    _calloutMapAnnotation.latitude  = annotation.coordinate.latitude;
    [mapView setCenterCoordinate:annotation.coordinate animated:YES];
    
    if ([annotation isKindOfClass:[CustomPointAnnotation class]]) {
        CustomPointAnnotation* anno = (CustomPointAnnotation *)annotation;
        _calloutMapAnnotation.info  = anno.info;
        _calloutMapAnnotation.isStopCarPopView = anno.isStopCarPopView;
    }
    [mapView addAnnotation:_calloutMapAnnotation];
}
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    if (_calloutMapAnnotation&&![view isKindOfClass:[CalloutAnnotationView class]]) {
        if (_calloutMapAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutMapAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [mapView removeAnnotation:_calloutMapAnnotation];
            _calloutMapAnnotation = nil;
        }
        mapView.showsUserLocation = YES;
    }
}
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
}
- (BOOL)onBusSearchString:(NSString*)city  startString:(NSString*)startString
                endString:(NSString*)endString BDMtype:(BDMPosition)type{
    BOOL flag = [super onBusSearchString:city  startString:startString
                               endString:endString BDMtype:type];
    if(!flag){
        [AlertViewHandle showAlertViewWithMessage:@"没有找到相关线路"];
    }
    return flag;
}

#pragma mark - UserDefinition Delegate
- (void)addRounteLineWithPosition:(CLLocationCoordinate2D)coordinate{
    BMKPlanNode* start = [BMKPlanNode new];
	start.pt           = _userCoordinate;
	BMKPlanNode* end   = [BMKPlanNode new];
    end.pt             = coordinate;
    
    NSMutableArray * array     = [[NSMutableArray alloc] initWithCapacity:10];
    BMKPlanNode* wayPointItem1 = [BMKPlanNode new];
    wayPointItem1.cityName     = @"上海";
    [array addObject:wayPointItem1];
    
	BOOL flag = [self.bdMapSearch drivingSearch:@"上海"  startNode:start
                                        endCity:@"上海"    endNode:end
                               throughWayPoints:array];
	if (flag) {
		NSLog(@"search success.");
	}else{
        NSLog(@"search failed!");
    }
}
-(void)viewPopViewDetailInScenicSpot:(NearbyOtherInfo*)info{
    ScenicSpotViewController *ssvc = [[ScenicSpotViewController alloc]init];
    ssvc.merchantOrSceneTitleText = @"景区信息";
    ssvc.idStr = info->nearId;
    [self.navigationController pushViewController:ssvc animated:YES];
}
#pragma mark - MapPopView protocol @optional
-(void)pmViewPopView:(id)sender{
    [self onBottomBtnClicked:sender];
}

#pragma mark - Events
//获取特定内容的 按钮事件
- (IBAction)onBottomBtnClicked:(id)sender {
    //    NSArray *array = @[@"美食",@"购物",@"娱乐",@"景区",@"住宿",@"旅行社"];
    UIButton *btn = sender;
    self.vcType = (enum VCType)btn.tag;  //标志是哪种附近信息，具体内容如array所示
    [self loadDataFromWebWithType:self.vcType];
}
#pragma mark - pubic method
- (void)setMapAreaWithCenter:(CLLocationCoordinate2D)center withTitle:(NSString*)title
            withUserPosition:(BOOL)y_n{
    self.willShowUserLocation     = y_n;
    int r                         = 2.5;
    BMKCoordinateRegion region    = BMKCoordinateRegionMakeWithDistance(center, r * km,  r * km);
    BMKCoordinateRegion newRegion = [self.mapView regionThatFits:region];
    [self.mapView setRegion:newRegion];
    
    BMKPointAnnotation * pa = [BMKPointAnnotation new];
    pa.coordinate           = center;
    pa.title                = title;
    
    [self.mapView addAnnotation:pa];
}

#pragma mark - private method
- (void)removeAllAnnotationAndOverlay{
    NSArray* array = [NSArray arrayWithArray:self.mapView.annotations];
    [self.mapView removeAnnotations:array];
    [self.mapView removeAnnotation:_calloutMapAnnotation];
    _calloutMapAnnotation = nil;
    array = [NSArray arrayWithArray:self.mapView.overlays];
    [self.mapView removeOverlays:array];
}

@end
