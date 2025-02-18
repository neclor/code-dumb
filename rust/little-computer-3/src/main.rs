mod lc3;
use lc3::*;


fn main() -> () {
	let mut lc3: LC3 = LC3::new();
	loop {
		lc3.update();
	}
}
