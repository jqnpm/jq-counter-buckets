#!/usr/bin/env bash


fileUnderTest="${BASH_SOURCE%/*}/../jq/main.jq"


read -d '' fourLineTests <<-'EOF' || true
create: Can not create fewer than 0 buckets. (Throws error.)
null
create(-1)


create: Can create 0 buckets.
null
create(0)
[]

create: Can create 1 bucket.
null
create(1)
[ 0 ]

create: Can create 3 buckets.
null
create(3)
[ 0, 0, 0 ]

create: Can create 10 buckets.
null
create(10)
[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]

increment: Can increment 0 bucket index 0 out of 3 buckets by 9.
[ 0, 0, 0 ]
increment(0; 9)
[ 9, 0, 0 ]

increment: Can increment 0 bucket index 1 out of 3 buckets by 9.
[ 0, 0, 0 ]
increment(1; 9)
[ 0, 9, 0 ]

increment: Can increment 0 bucket index 2 out of 3 buckets by 9.
[ 0, 0, 0 ]
increment(2; 9)
[ 0, 0, 9 ]

increment: Can increment 100 bucket index 0 out of 3 buckets by 9.
[ 100, 200, 300 ]
increment(0; 9)
[ 109, 200, 300 ]

increment: Can increment 200 bucket index 1 out of 3 buckets by 9.
[ 100, 200, 300 ]
increment(1; 9)
[ 100, 209, 300 ]

increment: Can increment 300 bucket index 2 out of 3 buckets by 9.
[ 100, 200, 300 ]
increment(2; 9)
[ 100, 200, 309 ]

increment: Can increment 100 bucket index 0 out of 3.
[ 100, 200, 300 ]
increment(0)
[ 101, 200, 300 ]

increment: Can increment 200 bucket index 1 out of 3.
[ 100, 200, 300 ]
increment(1)
[ 100, 201, 300 ]

increment: Can increment 300 bucket index 2 out of 3.
[ 100, 200, 300 ]
increment(2)
[ 100, 200, 301 ]

addition: Can not add counter buckets of different length. (Throws error.)
[ 101, 200, 300 ]
addition([ 100, 200 ])


addition: Can add counter buckets of the same length.
[ 101, 200, 300 ]
addition([ 100, 200, 301 ])
[ 201, 400, 601 ]
EOF

function testAllFourLineTests () {
	echo "$fourLineTests" | runAllFourLineTests
}


# Run tests above automatically.
# Custom tests can be added by adding new function with a name that starts with "test": function testSomething () { some test code; }
source "${BASH_SOURCE%/*}/test-runner.sh"
