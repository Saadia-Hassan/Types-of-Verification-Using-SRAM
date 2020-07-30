## *Importance of Functional Verification Techniques*
Often times, we hear the importance of Verification while designing a module. The design can be done, but before starting the physical manufacturing process, there are a number of factors that have to be taken care of. One of the critical factors is Verification. Because your design may work well and good under specified conditions, but what if, without your knowledge, your design is behaving in an undesirable way under unspecified conditions too? Confused? Okay, consider a simple example of a counter module. This counter is supposed to increment the count at every positive edge once you reset it. But unfortunately, while testing it, you find that it is staying at one value for an extra pulse, odd, isn't it? But you wouldn't have known this if you wouldn't have tested it. Your counter until 9, where actually it counted 18 in the process. Maybe this example isn't very reliable but I hope you understand the importance of testing and verification now. These simple mistakes can cause irrevocable damage in the long run. 

To test the designs, we have 2 important types of testbenches we write for verification while using Verilog HDL:
  1) Golden Vector testbench
  2) Randomization testbench
  
 You can check out the important terms [here.]( http://www.testbench.in/TB_06_SELF_CHECKING_TESTBENCH.html)
 
 To show it practically, I've taken a simple example of a 4x16 SRAM and written the code for both types of testbenches. 
 
 *Hope you find it useful and understandable!* 
 
 
 
