import "joelpurra/jq-dry" as DRY;
import "joelpurra/jq-disarray" as Disarray;


def create($count):
	if $count < 0 then
		error("Can't have fewer than 0 buckets.")
	else
		Disarray::zeros($count)
	end;

def increment($index; $count):
	if $index < 0 then
		error("index smaller than 0: " + ($index | tostring))
	elif $index >= length then
		error("index larger than bucket count: " + ($index | tostring))
	else
		.[$index] += $count
	end;

def increment($index):
	increment($index; 1);

# The name 'addition' isn't great, but 'add' is a jq built-in.
def addition($right):
	Disarray::ifSameLength($right; Disarray::addition($right));
