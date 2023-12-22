# Telecommunication Theory laboratory works and reports

This repository contains the lab works coded in the RTU "Telecommunication Theory" course. The lab works are coded in MATLAB while the reports are PDF files generated using LaTeX.

### Laboratory Work 1

The first lab work aims to analyze the simplest transmission techniques. First, a random dataset of bits is generated and then converted into a rectangular signal. Secondly, the Gaussian White Noise (_GWN_) is added to the source signal simulating a real-world disturbance and then, it will be detected with a simple threshold-based algorithm.

The same procedure will be made with a second type of modulation called __NRZ__ modulation. Shortly, this modulation doubles the distance between the zero-voltage level and the one-voltage level.

### Laboratory Work 2

In the second lab work, the detection algorithm changes: instead of comparing each received symbol with a threshold, the comparison happens between the fixed threshold and the average value of 100 samples making it harder for an error to occur.

In the second part of the lab work, the carrier type changed into a __BASK__ and the detection algorithm was energy-based. 

### Laboratory Work 3

The lab work number 3 is a preliminary code that will be used in the lab 4 and 5. In this lab work, the three modulation techniques __BASK__, __BFSK__ and __BPSK__ are used to transmit a random sequence of binary data. In this lab, the _GWN_ is not added using a MATLAB function but it is created in the script.

### Laboratory Work 4

The fourth lab work uses the lab 3 code and implements an optimal correlation receiver in all of the three modulation techniques. The correlation receiver is a detection technique that uses the _correlation integral_ to identify the correct symbol in the disturbed signal.

### Laboratory Work 5

ab work 5 uses the lab 3 code and implements a matched filter receiver in all of the three modulation techniques. This receiver uses the _convolution_ to identify the correct symbol in the disturbed signal.

### Laboratory Work 6

In the last lab work, we will take a look at the __QAM-16__ modulation technique which is also used in the 802.11 protocol (aka WiFi). In this laboratory work, we will see how this technique behaves with high noise situations by calculating the reactive BER value.
