main();

function main() {
    const args = process.argv;
    const numbers = args.slice(2);
    sleepSort(numbers);
}

function sleepSort(numbers) {
    numbers.forEach((number) => {
        setTimeout(() => {
            console.log(number);
        }, number * 10);
    });
}
