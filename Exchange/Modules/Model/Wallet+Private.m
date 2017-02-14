#import "Wallet+Private.h"
#import "Money.h"

@implementation Wallet (Private)

- (NSUInteger)indexOfCurrency:(NSString *)currencyID {
    let currencyIndex = [self.moneys indexOfObjectPassingTest:^BOOL(Money * _Nonnull money, NSUInteger idx, BOOL * _Nonnull stop) {
        
        return money.currencyID == currencyID;
    }];
    
    return currencyIndex;
}

@end
