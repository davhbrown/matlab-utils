# matlab-utils
Miscellaneous MATLAB functions &amp; scripts


### clr2blind()
Uses 8 colors more differentiable by a colorblind person.

![](https://github.com/davhbrown/matlab-utils/blob/master/img/clr2blind_demo-scale.png "clr2blind colors")

###### Inspired by: Wong (2011) Points of view: Color blindness. _Nature Methods_ 8:441.


### fftSuite()
Provides 3 frequency decompositions of an input signal: FFT, spectrogram, and instantaneous frequency.

![](https://github.com/davhbrown/matlab-utils/blob/master/img/splat-scale.png "fftSuite output")


### freqShift()
Shifts the frequency spectrum of a signal using its analytic signal derived form the Hilbert transform.

img

###### [Further reading](https://flylib.com/books/en/2.729.1/why_care_about_the_hilbert_transform_.html "https://flylib.com/books/en/2.729.1/why_care_about_the_hilbert_transform_.html")


### hilbertDecomp()
Decomposes a signal into its envelope and fine structure, outputting intstantaneous amplitude, phase, &amp; frequency components using the Hilbert transform.

![](https://github.com/davhbrown/matlab-utils/blob/master/img/sam_5000_100-scale.png "hilbertDecomp output")

###### Inspired by: Smith, Delgutte, Oxenham (2002) Chimaeric sounds reveal dichotomies in auditory perception. _Nature_ 416:87.
