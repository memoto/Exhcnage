#import <Foundation/Foundation.h>
#import "DataSource.h"

@interface CurrencyRateStorage : NSObject<Storage>

- (AnyPromise *)items;

@end

@interface CurrencyRateTestStorage : NSObject<Storage>

- (AnyPromise *)items;

@end
