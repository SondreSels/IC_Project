
plt=python3 ../../py/plot.py

pixSens:
	${MAKE} ngspice	 TB=pixelSensor_tb

sens:
	${MAKE} ngspice	 TB=sensor_tb

comp:
	${MAKE} ngspice	 TB=comp_tb

ngspice:
	ngspice -a ${TB}.cir
