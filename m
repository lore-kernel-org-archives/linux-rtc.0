Return-Path: <rtc-linux+bncBCEJHTXX7MFBB5F72HDAKGQEDR6TBUA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.kmu-office.ch (mail.kmu-office.ch. [178.209.48.109])
        by gmr-mx.google.com with ESMTPS id 82si9344wmg.3.2017.03.23.16.53.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 16:53:24 -0700 (PDT)
From: Stefan Agner <stefan@agner.ch>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Stefan Agner <stefan@agner.ch>
Subject: [rtc-linux] [PATCH] rtc: ds1307: support m41t0 variant
Date: Thu, 23 Mar 2017 16:54:57 -0700
Message-Id: <20170323235457.13223-1-stefan@agner.ch>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The m41t0 variant is very similar to the already supported m41t00
variant, with the notable exception of the oscillator fail bit.
The data sheet notes:

  If the oscillator fail (OF) bit is internally set to a '1,' this
  indicates that the oscillator has either stopped, or was stopped
  for some period of time and can be used to judge the validity of
  the clock and date data.

The bit will get cleared with a regular write of the system time,
so no changes are needed to clear it.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt |  1 +
 drivers/rtc/rtc-ds1307.c                                  | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index ad10fbe61562..3e0a34c88e07 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -160,6 +160,7 @@ sii,s35390a		2-wire CMOS real-time clock
 silabs,si7020		Relative Humidity and Temperature Sensors
 skyworks,sky81452	Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
 st,24c256		i2c serial eeprom  (24cxx)
+st,m41t0		Serial real-time clock (RTC)
 st,m41t00		Serial real-time clock (RTC)
 st,m41t62		Serial real-time clock (RTC) with alarm
 st,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 4ad97be48043..93b1e558fd54 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -38,6 +38,7 @@ enum ds_type {
 	ds_1340,
 	ds_1388,
 	ds_3231,
+	m41t0,
 	m41t00,
 	mcp794xx,
 	rx_8025,
@@ -52,6 +53,7 @@ enum ds_type {
 #	define DS1340_BIT_nEOSC		0x80
 #	define MCP794XX_BIT_ST		0x80
 #define DS1307_REG_MIN		0x01	/* 00-59 */
+#	define M41T0_BIT_OF		0x80
 #define DS1307_REG_HOUR		0x02	/* 00-23, or 1-12{am,pm} */
 #	define DS1307_BIT_12HR		0x40	/* in REG_HOUR */
 #	define DS1307_BIT_PM		0x20	/* in REG_HOUR */
@@ -182,6 +184,7 @@ static const struct i2c_device_id ds1307_id[] = {
 	{ "ds1388", ds_1388 },
 	{ "ds1340", ds_1340 },
 	{ "ds3231", ds_3231 },
+	{ "m41t0", m41t0 },
 	{ "m41t00", m41t00 },
 	{ "mcp7940x", mcp794xx },
 	{ "mcp7941x", mcp794xx },
@@ -201,6 +204,7 @@ static const struct acpi_device_id ds1307_acpi_ids[] = {
 	{ .id = "DS1388", .driver_data = ds_1388 },
 	{ .id = "DS1340", .driver_data = ds_1340 },
 	{ .id = "DS3231", .driver_data = ds_3231 },
+	{ .id = "M41T0", .driver_data = m41t0 },
 	{ .id = "M41T00", .driver_data = m41t00 },
 	{ .id = "MCP7940X", .driver_data = mcp794xx },
 	{ .id = "MCP7941X", .driver_data = mcp794xx },
@@ -396,6 +400,13 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 
 	dev_dbg(dev, "%s: %7ph\n", "read", ds1307->regs);
 
+	/* if oscillator fail bit is set, no data can be trusted */
+	if (ds1307->type == m41t0 &&
+	    ds1307->regs[DS1307_REG_MIN] & M41T0_BIT_OF) {
+		dev_warn_once(dev, "oscillator failed, set time!\n");
+		return -EINVAL;
+	}
+
 	t->tm_sec = bcd2bin(ds1307->regs[DS1307_REG_SECS] & 0x7f);
 	t->tm_min = bcd2bin(ds1307->regs[DS1307_REG_MIN] & 0x7f);
 	tmp = ds1307->regs[DS1307_REG_HOUR] & 0x3f;
@@ -1513,6 +1524,7 @@ static int ds1307_probe(struct i2c_client *client,
 	tmp = ds1307->regs[DS1307_REG_SECS];
 	switch (ds1307->type) {
 	case ds_1307:
+	case m41t0:
 	case m41t00:
 		/* clock halted?  turn it on, so clock can tick. */
 		if (tmp & DS1307_BIT_CH) {
@@ -1577,6 +1589,7 @@ static int ds1307_probe(struct i2c_client *client,
 	tmp = ds1307->regs[DS1307_REG_HOUR];
 	switch (ds1307->type) {
 	case ds_1340:
+	case m41t0:
 	case m41t00:
 		/*
 		 * NOTE: ignores century bits; fix before deploying
-- 
2.12.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
