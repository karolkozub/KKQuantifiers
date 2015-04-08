KKQuantifiers
=============

These functions allow you to check if any of or each of the elements of a collection fulfills a predicate. They are designed to make the condition easy to read.

Examples
--------

    if ([AnyOf(items) containsString:@"test"]) {
        // do something
    }
    
    if ([EachOf(objects) respondsToSelector:@selector(test)]) {
        // do something else
    }
