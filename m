Return-Path: <rtc-linux+bncBDHPTCWTXEHRBT77QGUQKGQERCDVYHQ@googlegroups.com>
Received: from gloria.sntech.de (gloria.sntech.de. [95.129.55.99])
        by gmr-mx.google.com with ESMTPS id p4si35461wiz.0.2015.04.04.17.20.31
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 04 Apr 2015 17:20:31 -0700 (PDT)
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: akpm@linux-foundation.org, Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [rtc-linux] [PATCH] rtc: hym8563: fix swapped enable/disable of
 clockout control bit
Date: Sun, 05 Apr 2015 02:20:24 +0200
Message-ID: <6712839.2ZD6yJNGY8@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

The hym8563 datasheet describes the clock output control-bit as "when set
to logic 0, the square wave output is enable, when set to logic 1, the
CLKOUT output is inhibited". But in reality the setting is exactly
opposite.

Before now, the clock output was not really used, but on the rk3288 soc
this generated clock is used to supply the temperature sensor block and
the swapped bit value prevented it from working. With the corrected value,
the tsadc now reports correct values.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/rtc/rtc-hym8563.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index d4a6561..0f710e9 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -66,7 +66,7 @@
 #define HYM8563_ALM_BIT_DISABLE	BIT(7)
 
 #define HYM8563_CLKOUT		0x0d
-#define HYM8563_CLKOUT_DISABLE	BIT(7)
+#define HYM8563_CLKOUT_ENABLE	BIT(7)
 #define HYM8563_CLKOUT_32768	0
 #define HYM8563_CLKOUT_1024	1
 #define HYM8563_CLKOUT_32	2
@@ -360,9 +360,9 @@ static int hym8563_clkout_control(struct clk_hw *hw, bool enable)
 		return ret;
 
 	if (enable)
-		ret &= ~HYM8563_CLKOUT_DISABLE;
+		ret |= HYM8563_CLKOUT_ENABLE;
 	else
-		ret |= HYM8563_CLKOUT_DISABLE;
+		ret &= ~HYM8563_CLKOUT_ENABLE;
 
 	return i2c_smbus_write_byte_data(client, HYM8563_CLKOUT, ret);
 }
@@ -386,7 +386,7 @@ static int hym8563_clkout_is_prepared(struct clk_hw *hw)
 	if (ret < 0)
 		return ret;
 
-	return !(ret & HYM8563_CLKOUT_DISABLE);
+	return !!(ret & HYM8563_CLKOUT_ENABLE);
 }
 
 static const struct clk_ops hym8563_clkout_ops = {
@@ -407,7 +407,7 @@ static struct clk *hym8563_clkout_register_clk(struct hym8563 *hym8563)
 	int ret;
 
 	ret = i2c_smbus_write_byte_data(client, HYM8563_CLKOUT,
-						HYM8563_CLKOUT_DISABLE);
+						0);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-- 
2.1.4


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
