Return-Path: <rtc-linux+bncBCMILY6JWQBBB7EK3O6QKGQE5MVYQIY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from wens.csie.org (mirror2.csie.ntu.edu.tw. [140.112.30.76])
        by gmr-mx.google.com with ESMTPS id d201si351792pfd.2.2016.08.19.01.38.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Aug 2016 01:38:20 -0700 (PDT)
From: Chen-Yu Tsai <wens@csie.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH v6 1/4] rtc: ac100: support clock-output-names in
 device tree binding
Date: Fri, 19 Aug 2016 15:42:23 +0800
Message-Id: <20160819074226.16636-2-wens@csie.org>
In-Reply-To: <20160819074226.16636-1-wens@csie.org>
References: <20160819074226.16636-1-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The ac100 device tree binding specifies the usage of clock-output-names
to specify the names of its 3 clock outputs. This is needed for orphan
clock resolution, when the ac100 is probed much later than any clocks
that consume any of its outputs. This wasn't supported by the driver.

Add support for this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v5:

  - New patch, based on mfd-rtc immutable branch given in

     http://www.spinics.net/lists/devicetree/msg137991.html

---
 drivers/rtc/rtc-ac100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index 70b4fd0f6122..2d0bb02a25d9 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -327,6 +327,8 @@ static int ac100_rtc_register_clks(struct ac100_rtc_dev *chip)
 			.flags = 0,
 		};
 
+		of_property_read_string_index(np, "clock-output-names",
+					      i, &init.name);
 		clk->regmap = chip->regmap;
 		clk->offset = AC100_CLKOUT_CTRL1 + i;
 		clk->hw.init = &init;
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
