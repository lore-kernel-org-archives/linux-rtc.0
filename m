Return-Path: <rtc-linux+bncBCXY5EGBQUIBB35D6KYAKGQEVK7YUIY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-out.m-online.net (mail-out.m-online.net. [212.18.0.9])
        by gmr-mx.google.com with ESMTPS id h2si673888wiy.0.2015.10.12.22.09.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 22:09:02 -0700 (PDT)
From: Heiko Schocher <hs@denx.de>
To: linux-kernel@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Georg.Soffel@bosch-si.com,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	devicetree@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: pcf8563: disable CLKOUT
Date: Tue, 13 Oct 2015 07:08:58 +0200
Message-Id: <1444712938-22865-1-git-send-email-hs@denx.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Disable the CLKOUT of the RTC after power-up.
After power-up/reset of the RTC, CLKOUT is enabled by default,
with CLKOUT enabled the RTC chip has 2-3 times higher power
consumption. If you do not need CLKOUT, you can disable the
CLKOUT with setting "disable-clkout" property.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 Documentation/devicetree/bindings/rtc/pcf8563.txt | 22 ++++++++++++++
 drivers/rtc/rtc-pcf8563.c                         | 37 +++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/pcf8563.txt

diff --git a/Documentation/devicetree/bindings/rtc/pcf8563.txt b/Documentation/devicetree/bindings/rtc/pcf8563.txt
new file mode 100644
index 0000000..36f49e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/pcf8563.txt
@@ -0,0 +1,22 @@
+* Philips PCF8563/Epson RTC8564 Real Time Clock
+
+Philips PCF8563/Epson RTC8564 Real Time Clock
+
+Required properties:
+see: Documentation/devicetree/bindings/i2c/trivial-devices.txt
+
+Optional property:
+- disable-clkout:
+  disable the CLKOUT of the RTC after power-up.
+  After power-up/reset of the RTC, CLKOUT is enabled by default,
+  with CLKOUT enabled the RTC chip has 2-3 times higher power
+  consumption. If you not need CLKOUT, you can disable the CLKOUT
+  with setting this property.
+
+Example:
+
+pcf8563@51 {
+	compatible = "nxp,pcf8563";
+	reg = <0x51>;
+	disable-clkout;
+};
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index e569243..fa9a412 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -53,6 +53,7 @@
 
 #define PCF8563_SC_LV		0x80 /* low voltage */
 #define PCF8563_MO_C		0x80 /* century */
+#define PCF8563_CLKOUT		0x80 /* CLKOUT */
 
 static struct i2c_driver pcf8563_driver;
 
@@ -74,6 +75,7 @@ struct pcf8563 {
 	 */
 	int c_polarity;	/* 0: MO_C=1 means 19xx, otherwise MO_C=1 means 20xx */
 	int voltage_low; /* incicates if a low_voltage was detected */
+	int disable_clkout;
 
 	struct i2c_client *client;
 };
@@ -186,6 +188,33 @@ static irqreturn_t pcf8563_irq(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static int pcf8563_disable_clkout(struct i2c_client *client)
+{
+	struct pcf8563 *pcf8563 = i2c_get_clientdata(client);
+	unsigned char buf;
+	int err;
+
+	if (!pcf8563->disable_clkout)
+		return 0;
+
+	err = pcf8563_read_block_data(client, PCF8563_REG_CLKO, 1, &buf);
+	if (err)
+		return err;
+
+	if (buf & PCF8563_CLKOUT) {
+		buf = 0x00;
+		dev_warn(&client->dev, "CLKOUT enabled! Disabling it...\n");
+		err = pcf8563_write_block_data(client, PCF8563_REG_CLKO, 1,
+				       &buf);
+		if (err < 0)
+			dev_err(&client->dev, "could not disable clock\n");
+	} else {
+		dev_info(&client->dev, "CLKOUT disabled.\n");
+	}
+
+	return 0;
+}
+
 /*
  * In the routines that deal directly with the pcf8563 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
@@ -235,6 +264,7 @@ static int pcf8563_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
 		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
+	pcf8563_disable_clkout(client);
 	return 0;
 }
 
@@ -406,6 +436,9 @@ static int pcf8563_probe(struct i2c_client *client,
 	int err;
 	unsigned char buf;
 	unsigned char alm_pending;
+#ifdef CONFIG_OF
+	int len;
+#endif
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
@@ -419,6 +452,10 @@ static int pcf8563_probe(struct i2c_client *client,
 
 	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
 
+#ifdef CONFIG_OF
+	if (of_find_property(client->dev.of_node, "disable-clkout", &len))
+		pcf8563->disable_clkout = 1;
+#endif
 	i2c_set_clientdata(client, pcf8563);
 	pcf8563->client = client;
 	device_set_wakeup_capable(&client->dev, 1);
-- 
2.1.0

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
