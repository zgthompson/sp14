import math
import numpy
def sine_array(amplitude, frequency):
    """
    Returns an array of integer values that represents the sine wave
    with the given amplitude and frequency for a duration of 1 second
    """
    a = []
    for cycle in range(frequency):
        for deg in range(0, 360, 5):
            # amplitude = 16000
            a.append( int(math.sin(math.radians(deg)) * amplitude) )
    return a

