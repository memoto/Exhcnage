#import "DataSource.h"
#import "CurrencyRateStorage.h"
#import "CurrencyRate.h"

@implementation CurrencyRateStorage {
    NSArray<CurrencyRate *> *_items;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = @[];
    }
    return self;
}

- (AnyPromise *)items {
    
    if (_items.count == 0) {
        // TODO: Make api request
    }
    
    return [AnyPromise promiseWithValue:_items];
}

@end

@implementation CurrencyRateTestStorage {
    NSArray<CurrencyRate *> *_items;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        let rates = @[
                      [CurrencyRate.alloc initWithCurrencyID:@"EUR" andRate:@1],
                      [CurrencyRate.alloc initWithCurrencyID:@"USD" andRate:@1.0623],
                      [CurrencyRate.alloc initWithCurrencyID:@"GBP" andRate:@0.85098]
                      ];
        _items = rates;
    }
    return self;
}

- (AnyPromise *)items {
    
   return [AnyPromise promiseWithValue:_items];
}

@end
