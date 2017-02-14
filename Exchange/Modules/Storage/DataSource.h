#import <Foundation/Foundation.h>
#import <PromiseKit/PromiseKit.h>

@protocol Storage <NSObject>

- (AnyPromise *)items;
@optional
- (void)setItems:(NSArray *)items;

@end


@interface DataSource<__covariant Item> : NSObject

- (instancetype)initWithStorage:(id<Storage>)storage;
- (AnyPromise *)first;
- (void)setItems:(NSArray<Item> *)items;

@end
