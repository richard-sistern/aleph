console.log("JavScript Array Methods")

const fruits = ['apple', 'apple', 'pear', 'pear', 'kiwi', 'cherry', 'banana', 'strawberry'];
console.log('Fruits array')
console.log(fruits);

// splice()
// Returns new array with elements either added and/or removed from original
const spliceOutput = fruits.splice(1,3);
console.log('fruits.splice(1,3)')
console.log(spliceOutput);

// sort()
// Sort the elements of an array in place and return the array
const sortOutput = fruits.sort();
console.log('fruits.sort()')
console.log(sortOutput);

// some()
// Returns true if at least one element in an array satisfies the test
const pearExists = fruits.some(fruit => fruit === 'pear');
console.log('fruits.some(fruit => fruit === \'pear\')');
console.log(pearExists);

// slice()
// Extracts a section of the calling array and returns a new array
const sliceOutput = fruits.slice(2);
console.log('fruits.slice(2)');
console.log(sliceOutput);

// reverse()
// Reverses the order of the elements of an array in place
const reversedFruits = fruits.reverse();
console.log('fruits.reverse()');
console.log(reversedFruits);

// push()
// Adds one or more elements to the end of an array, and returns the new length of the array
const pushOutput = fruits.push('kiwi', 'apple');
console.log('fruits.push(\'kiwi\', \'apple\')');
console.log(pushOutput);

// map()
// Returns new array containing results of the calling function on every element in the array
const doubledFruit = fruits.map(fruit => fruit + fruit);
console.log('fruits.map(fruit => fruit + fruit)');
console.log(doubledFruit);

// join()
// Join all elements of an array into a string
const fruitsGroup = fruits.join('');
console.log('fruits.join(\'\')');
console.log(fruitsGroup);

// includes()
// Determines whether the array contains a value, returns true or false
const includesApple = fruits.includes('apple');
console.log('fruits.includes(\'apple\')');
console.log(includesApple);
const includesPork = fruits.includes('pork');
console.log('fruits.includes(\'pork\')');
console.log(includesPork);

// forEach()
// Calls a function for each element in the array
console.log('fruits.forEach(fruit => console.log(fruit))');
fruits.forEach(fruit => console.log(fruit));

// findIndex()
// Returns the found index in the array, if an element in the array satisfies the testing function, or -1 if not
const pearIndex = fruits.findIndex(fruit => fruit === 'pear');
console.log('fruits.findIndex(fruit => fruit === \'pear\')');
console.log(pearIndex);

// find()
// Returns the found element in the array, if some element in the array satisfies the testing function, or undefined if not found
const findApple = fruits.find(fruit => fruit === 'apple');
console.log('fruits.find(fruit => fruit === \'apple\')');
console.log(findApple);

// filter()
// Returns a new array containing all elements of the calling array for which the provided filtering function returns true
const onlyApples = fruits.filter(fruit => fruit === 'apple');
console.log('fruits.filter(fruit => fruit === \'apple\'');
console.log(onlyApples);

// fill()
// Fills all the elements of an array from a start index to an end index with a static value
const lemons = fruits.fill('lemon');
console.log('fruits.fill(\'lemon\')');
console.log(lemons);

// every()
// Returns true if every element in this array satisfies the testing function
const allBananas = fruits.every(fruit => fruit === 'banana')
console.log('fruits.every(fruit => fruit === \'apple\')');
console.log(allBananas);

// copyWithin()
// Copies a sequence of array elements within the array
const fruitsCopy = fruits.copyWithin(0, 2);
console.log('fruits.copyWithin(0, 2)');
console.log(fruitsCopy);

// concat()
// Returns a new array that is this array joined with other array(s) and/or value(s)
const food = fruits.concat(lemons);
console.log('fruits.concat(lemons)');
console.log(food);