Return-Path: <rtc-linux+bncBC6YH6VTZQDRBCNIU3BAKGQE6UDDZKY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d199si1463107wmd.1.2016.12.08.09.10.32
        for <rtc-linux@googlegroups.com>;
        Thu, 08 Dec 2016 09:10:32 -0800 (PST)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 3/3] rtc: armada38x: Prepare for being use on 64 bits
Date: Thu,  8 Dec 2016 18:10:10 +0100
Message-Id: <20161208171010.29446-4-gregory.clement@free-electrons.com>
In-Reply-To: <20161208171010.29446-1-gregory.clement@free-electrons.com>
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The drivers are supposed to be portable, however there are few assumption
done here about the unsigned long size. Make sure we use the accurate
width for the variable.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/rtc/rtc-armada38x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index b8a74ffaae80..c4138130febf 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -84,14 +84,14 @@ static void rtc_update_mbus_timing_params(struct armada38x_rtc *rtc)
 }
 
 struct str_value_to_freq {
-	unsigned long value;
+	u32 value;
 	u8 freq;
 } __packed;
 
-static unsigned long read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
+static u32 read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
 {
-	unsigned long value_array[SAMPLE_NR], i, j, value;
-	unsigned long max = 0, index_max = SAMPLE_NR - 1;
+	int i, j, index_max = SAMPLE_NR - 1;
+	u32 value_array[SAMPLE_NR], value, max = 0;
 	struct str_value_to_freq value_to_freq[SAMPLE_NR];
 
 	for (i = 0; i < SAMPLE_NR; i++) {
-- 
2.10.2

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
