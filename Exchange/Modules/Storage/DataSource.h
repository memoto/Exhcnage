#import <Foundation/Foundation.h>
#import <PromiseKit/PromiseKit.h>

@protocol Storage <NSObject>

- (AnyPromise *)items;
@optional
- (void)setItems:(NSArray *)items;

@end


@interface DataSource<__covariant Item> : NSObject

@property (nonatomic, copy) void(^onNewData)(NSArray<Item> *);

- (instancetype)initWithStorage:(id<Storage>)storage;

- (void)fetch;
- (void)setItems:(NSArray<Item> *)items;

@end
