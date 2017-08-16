Return-Path: <rtc-linux+bncBAABBYWPZ3GAKGQEPSDBFEQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from regular1.263xmail.com (regular1.263xmail.com. [211.150.99.132])
        by gmr-mx.google.com with ESMTPS id q20si788607itc.2.2017.08.15.19.03.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 19:03:14 -0700 (PDT)
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
Subject: [rtc-linux] [RESEND v9 11/12] mfd: rk808: Add RK805 power key support
Date: Wed, 16 Aug 2017 10:02:07 +0800
Message-Id: <1502848927-389-1-git-send-email-chenjh@rock-chips.com>
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

Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/rk808.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index c803d2d..216fbf6 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -94,6 +94,19 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 };
 
+static struct resource rk805_key_resources[] = {
+	{
+		.start  = RK805_IRQ_PWRON_FALL,
+		.end    = RK805_IRQ_PWRON_FALL,
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		.start  = RK805_IRQ_PWRON_RISE,
+		.end    = RK805_IRQ_PWRON_RISE,
+		.flags  = IORESOURCE_IRQ,
+	}
+};
+
 static const struct mfd_cell rk805s[] = {
 	{ .name = "rk808-clkout", },
 	{ .name = "rk808-regulator", },
@@ -103,6 +116,10 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = &rtc_resources[0],
 	},
+	{	.name = "rk805-pwrkey",
+		.num_resources = ARRAY_SIZE(rk805_key_resources),
+		.resources = &rk805_key_resources[0],
+	},
 };
 
 static const struct mfd_cell rk808s[] = {
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
