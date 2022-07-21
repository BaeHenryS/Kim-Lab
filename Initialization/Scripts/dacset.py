import warnings
import serial as serial
import serial.tools.list_ports

arduino_ports = [
    p.device
    for p in serial.tools.list_ports.comports()
    #if 'Arduino' in p.description
]

if not arduino_ports:
    raise IOError("No Arduino Found")
if len(arduino_ports) > 1:
    warnings.warn('Multiple Arduinos Found so Using the First One')
    
ser = serial.Serial(arduino_ports[0], 115200, timeout = 1)
    


def initialize():
    ser.write(str.encode('INITIALIZE\r'))
    print("Initialized")

def setVoltage(voltage):
    ser.write(str.encode('SET,0,'+str(voltage)+'\r'))

