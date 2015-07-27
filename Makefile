CFLAGS = -O
OBJS = rpi_touch_driver.o
PROG = rpi_touch_driver

${PROG}: ${OBJS}
	${CC} -o ${PROG} ${OBJS}

clean:
	-rm -f ${PROG} ${OBJS}

install: ${PROG}
	cp ${PROG} /usr/local/bin && chmod 755 /usr/local/bin/${PROG}
	cp 90-rpi-touch.rules /etc/udev/rules.d && chmod 644 /etc/udev/rules.d/90-rpi-touch.rules && udevadm control --reload-rules
	cp rpi-touch-driver.service /etc/systemd/system && chmod 755 /etc/systemd/system/rpi-touch-driver.service && systemctl daemon-reload && systemctl enable rpi-touch-driver
	systemctl start rpi-touch-driver