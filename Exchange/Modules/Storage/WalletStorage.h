#import <Foundation/Foundation.h>

@class AnyPromise;

@interface WalletTestStorage : NSObject<Storage>

- (AnyPromise *)items;
- (void)setItems:(NSArray *)items;

@end
