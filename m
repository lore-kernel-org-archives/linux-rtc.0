Return-Path: <rtc-linux+bncBAABBWGNZ3GAKGQEDW3LDVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from regular1.263xmail.com (regular1.263xmail.com. [211.150.99.131])
        by gmr-mx.google.com with ESMTPS id b2si736021itg.4.2017.08.15.18.58.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 18:58:48 -0700 (PDT)
From: Joseph Chen <chenjh@rock-chips.com>
To: gnurou@gmail.com,
	linus.walleij@linaro.org,
	dmitry.torokhov@gmail.com,
	lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	broonie@kernel.org,
	zhangqing@rock-chips.com,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	linux-rockchip@lists.infradead.org,
	wdc@rock-chips.com,
	tony.xie@rock-chips.com,
	linux-input@vger.kernel.org,
	mark.rutland@arm.com,
	w.egorov@phytec.de,
	linux-clk@vger.kernel.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	Joseph Chen <chenjh@rock-chips.com>
Subject: [rtc-linux] [RESEND v9 01/12] mfd: rk808: fix up the chip id get failed
Date: Wed, 16 Aug 2017 09:56:57 +0800
Message-Id: <1502848628-27757-2-git-send-email-chenjh@rock-chips.com>
In-Reply-To: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
References: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Elaine Zhang <zhangqing@rock-chips.com>

the rk8xx chip id is:
((MSB << 8) | LSB) & 0xfff0

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/rk808.c       | 21 +++++++++++++++------
 include/linux/mfd/rk808.h |  1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index fd087cb..8e60eba 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -325,7 +325,7 @@ static int rk808_probe(struct i2c_client *client,
 	void (*pm_pwroff_fn)(void);
 	int nr_pre_init_regs;
 	int nr_cells;
-	int pm_off = 0;
+	int pm_off = 0, msb, lsb;
 	int ret;
 	int i;
 
@@ -333,14 +333,23 @@ static int rk808_probe(struct i2c_client *client,
 	if (!rk808)
 		return -ENOMEM;
 
-	rk808->variant = i2c_smbus_read_word_data(client, RK808_ID_MSB);
-	if (rk808->variant < 0) {
-		dev_err(&client->dev, "Failed to read the chip id at 0x%02x\n",
+	/* Read chip variant */
+	msb = i2c_smbus_read_byte_data(client, RK808_ID_MSB);
+	if (msb < 0) {
+		dev_err(&client->dev, "failed to read the chip id at 0x%x\n",
 			RK808_ID_MSB);
-		return rk808->variant;
+		return msb;
 	}
 
-	dev_dbg(&client->dev, "Chip id: 0x%x\n", (unsigned int)rk808->variant);
+	lsb = i2c_smbus_read_byte_data(client, RK808_ID_LSB);
+	if (lsb < 0) {
+		dev_err(&client->dev, "failed to read the chip id at 0x%x\n",
+			RK808_ID_LSB);
+		return lsb;
+	}
+
+	rk808->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
+	dev_info(&client->dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
 
 	switch (rk808->variant) {
 	case RK808_ID:
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 83701ef..54feb14 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -298,6 +298,7 @@ enum rk818_reg {
 #define VOUT_LO_INT	BIT(0)
 #define CLK32KOUT2_EN	BIT(0)
 
+#define RK8XX_ID_MSK			0xfff0
 enum {
 	BUCK_ILMIN_50MA,
 	BUCK_ILMIN_100MA,
-- 
1.9.1


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
