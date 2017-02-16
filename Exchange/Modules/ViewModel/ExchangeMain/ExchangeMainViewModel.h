#import <Foundation/Foundation.h>

@class ExchangeOptionsViewModel;
@class Wallet;

@interface ExchangeMainViewModel : NSObject

@property (nonatomic, strong) ExchangeOptionsViewModel *top;
@property (nonatomic, strong) ExchangeOptionsViewModel *bottom;

- (void)refreshWithWallet:(Wallet *)wallet;

@end
