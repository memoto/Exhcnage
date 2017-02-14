#import "DataSource.h"
#import "WalletStorage.h"
#import "Money.h"
#import "Wallet.h"


@implementation WalletTestStorage {
    NSArray<Wallet *> *_items;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        let moneys = @[
                       [Money.alloc initWithCurrencyID:@"EUR" andAmount:@100],
                       [Money.alloc initWithCurrencyID:@"USD" andAmount:@100],
                       [Money.alloc initWithCurrencyID:@"GBP" andAmount:@100]
                       ];
        let wallet = [Wallet.alloc initWithMoneys:moneys];
        _items = @[wallet];
    }
    return self;
}

- (AnyPromise *)items {
    
    return [AnyPromise promiseWithValue:_items];
}

- (void)setItems:(NSArray *)items {
    _items = items;
}


@end
