Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: Re: [PATCH] rtc: snvs: improve timeout handling in snvs_rtc_enable()
From: =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Message-Id: <20527.38172.621130.368019@ipc1.ka-ro>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: rtc-linux@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Kim Phillips <kim.phillips@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Stephen Boyd <sboyd@codeaurora.org>, linux-arm-kernel@lists.infradead.org
Date: Sat, 18 Aug 2012 15:14:04 +0200
List-ID: <rtc-linux.googlegroups.com>

Shawn Guo writes:
> On Sat, Aug 18, 2012 at 10:10:08AM +0200, Lothar Waßmann wrote:
> > If snvs_rtc_enable() happens to be descheduled for a period longer
> > than the timout period, a timeout may be indicated even if the RTC
> > status has changed meanwhile. Force a status read at the end of the
> > timeout period to prevent bogus timeout errors.
> > 
> > 
> > Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
> > ---
> >  drivers/rtc/rtc-snvs.c |   22 +++++++++++++---------
> >  1 files changed, 13 insertions(+), 9 deletions(-)
> > 
> >  Compile tested only due to lack of HW.
> 
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
> 
> A small nitpick below.
> 
> > 
> > diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> > index 912f116..dc921b2 100644
> > --- a/drivers/rtc/rtc-snvs.c
> > +++ b/drivers/rtc/rtc-snvs.c
> > @@ -81,6 +81,13 @@ static void rtc_write_sync_lp(void __iomem *ioaddr)
> >  	}
> >  }
> >  
> > +static int snvs_rtc_enable_done(int enable, void __iomem *addr)
> 
> Can we rename parameter "addr" to "ioaddr" and put it before "enable",
> also change "enable" to bool?
> 
OK. The resulting assembler code of the patch below is identical to
the previous version of this patch.


Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/rtc/rtc-snvs.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 912f116..a757cb9 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -81,6 +81,13 @@ static void rtc_write_sync_lp(void __iomem *ioaddr)
 	}
 }
 
+static int snvs_rtc_enable_done(void __iomem *ioaddr, bool enable)
+{
+	u32 lpcr = readl(ioaddr + SNVS_LPCR);
+
+	return enable ^ !(lpcr & SNVS_LPCR_SRTC_ENV);
+}
+
 static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(1);
@@ -99,18 +106,15 @@ static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
 	spin_unlock_irqrestore(&data->lock, flags);
 
 	while (1) {
-		lpcr = readl(data->ioaddr + SNVS_LPCR);
+		if (snvs_rtc_enable_done(data->ioaddr, enable))
+			break;
 
-		if (enable) {
-			if (lpcr & SNVS_LPCR_SRTC_ENV)
-				break;
-		} else {
-			if (!(lpcr & SNVS_LPCR_SRTC_ENV))
+		if (time_after(jiffies, timeout)) {
+			if (snvs_rtc_enable_done(data->ioaddr, enable))
 				break;
+			else
+				return -ETIMEDOUT;
 		}
-
-		if (time_after(jiffies, timeout))
-			return -ETIMEDOUT;
 	}
 
 	return 0;
