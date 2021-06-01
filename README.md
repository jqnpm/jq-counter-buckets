<p align="center">
  <a href="https://github.com/joelpurra/jqnpm"><img src="https://raw.githubusercontent.com/joelpurra/jqnpm/master/resources/logotype/penrose-triangle.svg?sanitize=true" alt="jqnpm logotype, a Penrose triangle" width="100" border="0" /></a>
</p>

# [jq-counter-buckets](https://github.com/joelpurra/jq-counter-buckets)

Count occurrences of values within a range.



> ## ⚠️ This project has been archived
>
> No future updates are planned. Feel free to continue using it, but expect no support.



This is a package for the command-line JSON processor [`jq`](https://stedolan.github.io/jq/). Install the package in your jq project/package directory with [`jqnpm`](https://github.com/joelpurra/jqnpm):

```bash
jqnpm install joelpurra/jq-counter-buckets
```



## Usage


```jq
import "joelpurra/jq-counter-buckets" as CounterBuckets;

# Create counter buckets, increment their counters, add two together.
CounterBuckets::create(10)            # [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
| CounterBuckets::increment(4)        # [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ]
| CounterBuckets::increment(0)        # [ 1, 0, 0, 0, 1, 0, 0, 0, 0, 0 ]
| CounterBuckets::increment(9)        # [ 1, 0, 0, 0, 1, 0, 0, 0, 0, 1 ]
| CounterBuckets::increment(9)        # [ 1, 0, 0, 0, 1, 0, 0, 0, 0, 2 ]
| CounterBuckets::increment(5; 99)    # [ 1, 0, 0, 0, 1, 99, 0, 0, 0, 2 ]
| . as $first

| CounterBuckets::create(10)          # [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
| CounterBuckets::increment(3; 10)    # [ 0, 0, 0, 10, 0, 0, 0, 0, 0, 0 ]
| CounterBuckets::increment(4)        # [ 0, 0, 0, 10, 1, 0, 0, 0, 0, 0 ]
| CounterBuckets::increment(5)        # [ 0, 0, 0, 10, 1, 1, 0, 0, 0, 0 ]
| . as $second

| $first
| CounterBuckets::addition($second)   # [1, 0, 0,10,2,100, 0, 0, 0,2]
| . as $combined

| {
	first: $first,
	second: $second,
	combined: $combined
}
```



---

## License
Copyright (c) 2015 Joel Purra <https://joelpurra.com/>
All rights reserved.

When using **jq-counter-buckets**, comply to the MIT license. Please see the LICENSE file for details.
