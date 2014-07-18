#import "BaseObject.h"

@interface MainPageInfo : BaseObject{
@public
    NSString *relationId;
    NSString *imgUrl;
    NSString *carouselType;
}
@end


@interface MainPageData : BaseObject{
@public
    NSMutableArray *arrayMainPageInfo;
}
@end


