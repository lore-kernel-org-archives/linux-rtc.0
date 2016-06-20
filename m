Return-Path: <rtc-linux+bncBCMILY6JWQBBB2NUTW5QKGQELJVG3QY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from wens.csie.org (mirror2.csie.ntu.edu.tw. [140.112.30.76])
        by gmr-mx.google.com with ESMTPS id un17si4619908pab.0.2016.06.19.19.52.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2016 19:52:25 -0700 (PDT)
From: Chen-Yu Tsai <wens@csie.org>
To: Mark Brown <broonie@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [rtc-linux] [PATCH v3 1/8] regmap: Support bulk writes for devices
 without raw formatting
Date: Mon, 20 Jun 2016 10:52:11 +0800
Message-Id: <1466391138-12862-2-git-send-email-wens@csie.org>
In-Reply-To: <1466391138-12862-1-git-send-email-wens@csie.org>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

When doing a bulk writes from a device which lacks raw I/O support we
fall back to doing register at a time reads but we still use the raw
formatters in order to render the data into the word size used by the
device (since bulk reads still operate on the device word size rather
than unsigned ints).  This means that devices without raw formatting
such as those that provide reg_read() are not supported.  Provide
handling for them by copying the values read into native endian values
of the appropriate size.

This complements commit d5b98eb12420 ("regmap: Support bulk reads for
devices without raw formatting").

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v2: none
Changes since v1: none
---
 drivers/base/regmap/regmap.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index df2d2ef5d6b3..51fa7d66a393 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1777,8 +1777,6 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 	size_t val_bytes = map->format.val_bytes;
 	size_t total_size = val_bytes * val_count;
 
-	if (map->bus && !map->format.parse_inplace)
-		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
 
@@ -1789,7 +1787,8 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 	 *
 	 * The first if block is used for memory mapped io. It does not allow
 	 * val_bytes of 3 for example.
-	 * The second one is used for busses which do not have this limitation
+	 * The second one is for busses that do not provide raw I/O.
+	 * The third one is used for busses which do not have these limitations
 	 * and can write arbitrary value lengths.
 	 */
 	if (!map->bus) {
@@ -1825,6 +1824,32 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		}
 out:
 		map->unlock(map->lock_arg);
+	} else if (map->bus && !map->format.parse_inplace) {
+		const u8 *u8 = val;
+		const u16 *u16 = val;
+		const u32 *u32 = val;
+		unsigned int ival;
+
+		for (i = 0; i < val_count; i++) {
+			switch (map->format.val_bytes) {
+			case 4:
+				ival = u32[i];
+				break;
+			case 2:
+				ival = u16[i];
+				break;
+			case 1:
+				ival = u8[i];
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			ret = regmap_write(map, reg + (i * map->reg_stride),
+					   ival);
+			if (ret)
+				return ret;
+		}
 	} else if (map->use_single_write ||
 		   (map->max_raw_write && map->max_raw_write < total_size)) {
 		int chunk_stride = map->reg_stride;
-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
