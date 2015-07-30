Return-Path: <rtc-linux+bncBDS7HNEFSALRBVW54WWQKGQERM6RLBI@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id cj6si777351wib.1.2015.07.29.17.24.54
        for <rtc-linux@googlegroups.com>;
        Wed, 29 Jul 2015 17:24:54 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 4/5] rtc: at91sam9: get sclk rate after enabling it
Date: Thu, 30 Jul 2015 02:24:31 +0200
Message-Id: <1438215872-27794-4-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
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

See help for clk_get_rate(): "obtain the current clock rate (in Hz) for a
clock source. This is only valid once the clock source has been enabled."

It currently returns the correct value but that may not stay that way.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 23f721d049b2..f9e85ace5e71 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -425,18 +425,19 @@ static int at91_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->sclk))
 		return PTR_ERR(rtc->sclk);
 
-	sclk_rate = clk_get_rate(rtc->sclk);
-	if (!sclk_rate || sclk_rate > AT91_RTT_RTPRES) {
-		dev_err(&pdev->dev, "Invalid slow clock rate\n");
-		return -EINVAL;
-	}
-
 	ret = clk_prepare_enable(rtc->sclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not enable slow clock\n");
 		return ret;
 	}
 
+	sclk_rate = clk_get_rate(rtc->sclk);
+	if (!sclk_rate || sclk_rate > AT91_RTT_RTPRES) {
+		dev_err(&pdev->dev, "Invalid slow clock rate\n");
+		ret = -EINVAL;
+		goto err_clk;
+	}
+
 	mr = rtt_readl(rtc, MR);
 
 	/* unless RTT is counting at 1 Hz, re-initialize it */
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
