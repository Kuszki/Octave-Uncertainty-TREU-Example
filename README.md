# Octave-Uncertainty-TREU-Example
Example of the application of the method for estimating the variance value of the time delay related error signals.

## Case 1: `test_var_1_*.m`
A case where there is only an error related to the delay in starting the measurement process. The symbol `*` denotes the type of distribution of the values ​​of the analyzed delay realization.

## Case 2: `test_var_2_*.m`
The case where there is only an error related to the fluctuation of the sampling period. The symbol `*` denotes the type of distribution of the realization values ​​of the analyzed delay.

## Case 3: `test_var_2_*a_*b.m`
The case where there is both an error related to the sampling period fluctuation and an error related to the measurement process start delay. The symbol `*a` denotes the type of distribution of the realization values ​​of the measurement process initiation delay, while the symbol `*b` denotes the type of distribution of the realization values ​​for the sampling period fluctuation phenomenon.

## Running experiments
To run an experiment, run the selected script, and to modify its parameters, edit the parameters defined at the beginning of the script.

## Requirements

- Recent version of GNU Octave or MATLAB[^1].
- Statistics package for GNU Octave.
- BASH and GNU Parallel packet.

[^1]: MATLAB usage requires minor changes in libraries due to some incompatibility.

## Credits

All files in `libs` are part of [Octave-FWT-Utils](https://github.com/Kuszki/Octave-FWT-Utils) project licensed under GPL-3.0 license.

## License

This project is licensed under GPL-3.0 license.
