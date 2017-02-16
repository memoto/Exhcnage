#import <Foundation/Foundation.h>

@class ExchangeOptionsViewModel;

@interface ExchangeMainViewModel : NSObject


@property (nonatomic, strong) ExchangeOptionsViewModel *top;
@property (nonatomic, strong) ExchangeOptionsViewModel *bottom;

@end
