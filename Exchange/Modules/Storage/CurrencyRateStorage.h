#import <Foundation/Foundation.h>

@interface CurrencyRateStorage : NSObject<Storage>

- (AnyPromise *)items;

@end

@interface CurrencyRateTestStorage : NSObject<Storage>

- (AnyPromise *)items;

@end
