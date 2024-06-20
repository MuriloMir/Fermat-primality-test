// This software is able to tell if a number is prime by using the Fermat's Primality Test.

// import the tools we need
import std.bigint: BigInt;
import std.math : sqrt;
import std.random : uniform;
import std.stdio : readf, writeln;

// this function will calculate the GDC of 2 numbers, we use 'ulong' because they may be very big
ulong gdc(ulong a, ulong b)
{
    // start a loop to keep calculating the mod between the numbers until the result is 0
    for (ulong result = a % b; result > 0; result = a % b)
        // update the numbers in order to move on to the next step
        a = b, b = result;

    // return the final value with the GDC
    return b;
}

// this function will tell if a number is prime, with the Fermat's Primality Test algorithm
bool fermatPrimeTest(ulong number, int trials)
{
    // if the number is 1, 2 or 3
    if (number < 4)
        // it will be false when it is 1 and it will be true otherwise
        return number > 1;
    // if the number is even
    else if (number % 2 == 0)
        // it is not prime
        return false;

    // start a loop by setting a limit which is the square root of the number, then a tester value which is picked randomly, it runs 'trials' times
    for (ulong limit = cast(ulong) sqrt(cast(real) number) + 1, tester = uniform(2, limit); trials-- > 0; tester = uniform(2, limit))
    {
        // if their GDC isn't 1, we use the 'gdc()' function above
        if (gdc(number, tester) != 1)
            // then it is a composite
            return false;
        // if Fermat's Little Theorem (a ^ b mod b == a) doesn't work, notice we convert it to 'BigInt' because the result may be gigantic
        else if (BigInt(tester) ^^ number % number != tester)
            // then it is a composite
            return false;

        // let the user know how much more until it is done
        writeln(trials, " trials left.");
    }

    // if it got this far then it is very likely a prime
    return true;
}

void main()
{
    // this will be number to be tested
    ulong number;

    // tell the user what to do
    writeln("Type the number you want to test: ");
    // register what the user types
    readf("%d", number);
    // test it with the 'fermatPrimeTest()' function above, then show the result, we use 8 trials, which is enough for a reliable result
    writeln(fermatPrimeTest(number, 8));
}
