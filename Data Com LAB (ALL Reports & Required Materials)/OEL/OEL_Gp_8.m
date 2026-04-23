    $ nano blinkLED.py              
    line  
    import RPi.GPIO as GPIO
    import time
                                # 
    # to create a text file under the name blinkLED write this at the command 
        # RPi.GPIO library will allow us to control the GPIO pins. 
    time library contains the sleep ()  
    GPIO.setmode(GPIO.BCM)   # BCM pin numbering is used  
    GPIO.setwarnings(False)       # to disable warnings 
    GPIO.setup(14, GPIO.OUT) # to set GPIO14 as an output.  
    GPIO.output(14, GPIO.HIGH) # to specify the GPIO 14 as HIGH 
    print "LED is ON"
                    # show message to Terminal.  
    time.sleep(2)                          # for two seconds  
    GPIO.output(14, GPIO.LOW) # to specify the GPIO 14 as LOW  
    print "LED is OFF"
                # show message to Terminal.