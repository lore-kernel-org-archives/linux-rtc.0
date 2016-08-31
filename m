Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBP6ETC7AKGQELPXDQBY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id o85si2770038wme.0.2016.08.30.17.18.07
        for <rtc-linux@googlegroups.com>;
        Tue, 30 Aug 2016 17:18:07 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Oleksij Rempel <linux@rempel-privat.de>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 2/2] rtc: asm9260: rework locking
Date: Wed, 31 Aug 2016 02:18:05 +0200
Message-Id: <20160831001805.8367-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20160831001805.8367-1-alexandre.belloni@free-electrons.com>
References: <20160831001805.8367-1-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The rtc-asm9260 driver uses a discrete spinlock (wrongly uninitialized).
Use the rtc mutex to lock mmio accesses instead.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-asm9260.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
index 5219916ce11d..812f131da694 100644
--- a/drivers/rtc/rtc-asm9260.c
+++ b/drivers/rtc/rtc-asm9260.c
@@ -112,8 +112,6 @@ struct asm9260_rtc_priv {
 	void __iomem		*iobase;
 	struct rtc_device	*rtc;
 	struct clk		*clk;
-	/* io lock */
-	spinlock_t		lock;
 };
 
 static irqreturn_t asm9260_rtc_irq(int irq, void *dev_id)
@@ -122,11 +120,13 @@ static irqreturn_t asm9260_rtc_irq(int irq, void *dev_id)
 	u32 isr;
 	unsigned long events = 0;
 
+	mutex_lock(&priv->rtc->ops_lock);
 	isr = ioread32(priv->iobase + HW_CIIR);
 	if (!isr)
 		return IRQ_NONE;
 
 	iowrite32(0, priv->iobase + HW_CIIR);
+	mutex_unlock(&priv->rtc->ops_lock);
 
 	events |= RTC_AF | RTC_IRQF;
 
@@ -139,9 +139,7 @@ static int asm9260_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
 	u32 ctime0, ctime1, ctime2;
-	unsigned long irq_flags;
 
-	spin_lock_irqsave(&priv->lock, irq_flags);
 	ctime0 = ioread32(priv->iobase + HW_CTIME0);
 	ctime1 = ioread32(priv->iobase + HW_CTIME1);
 	ctime2 = ioread32(priv->iobase + HW_CTIME2);
@@ -155,7 +153,6 @@ static int asm9260_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		ctime1 = ioread32(priv->iobase + HW_CTIME1);
 		ctime2 = ioread32(priv->iobase + HW_CTIME2);
 	}
-	spin_unlock_irqrestore(&priv->lock, irq_flags);
 
 	tm->tm_sec  = (ctime0 >> BM_CTIME0_SEC_S)  & BM_CTIME0_SEC_M;
 	tm->tm_min  = (ctime0 >> BM_CTIME0_MIN_S)  & BM_CTIME0_MIN_M;
@@ -174,9 +171,7 @@ static int asm9260_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int asm9260_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
-	unsigned long irq_flags;
 
-	spin_lock_irqsave(&priv->lock, irq_flags);
 	/*
 	 * make sure SEC counter will not flip other counter on write time,
 	 * real value will be written at the enf of sequence.
@@ -191,7 +186,6 @@ static int asm9260_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	iowrite32(tm->tm_hour, priv->iobase + HW_HOUR);
 	iowrite32(tm->tm_min,  priv->iobase + HW_MIN);
 	iowrite32(tm->tm_sec,  priv->iobase + HW_SEC);
-	spin_unlock_irqrestore(&priv->lock, irq_flags);
 
 	return 0;
 }
@@ -199,9 +193,7 @@ static int asm9260_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static int asm9260_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
-	unsigned long irq_flags;
 
-	spin_lock_irqsave(&priv->lock, irq_flags);
 	alrm->time.tm_year = ioread32(priv->iobase + HW_ALYEAR);
 	alrm->time.tm_mon  = ioread32(priv->iobase + HW_ALMON);
 	alrm->time.tm_mday = ioread32(priv->iobase + HW_ALDOM);
@@ -213,7 +205,6 @@ static int asm9260_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alrm->enabled = ioread32(priv->iobase + HW_AMR) ? 1 : 0;
 	alrm->pending = ioread32(priv->iobase + HW_CIIR) ? 1 : 0;
-	spin_unlock_irqrestore(&priv->lock, irq_flags);
 
 	return rtc_valid_tm(&alrm->time);
 }
@@ -221,9 +212,7 @@ static int asm9260_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static int asm9260_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
-	unsigned long irq_flags;
 
-	spin_lock_irqsave(&priv->lock, irq_flags);
 	iowrite32(alrm->time.tm_year, priv->iobase + HW_ALYEAR);
 	iowrite32(alrm->time.tm_mon,  priv->iobase + HW_ALMON);
 	iowrite32(alrm->time.tm_mday, priv->iobase + HW_ALDOM);
@@ -234,7 +223,6 @@ static int asm9260_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	iowrite32(alrm->time.tm_sec,  priv->iobase + HW_ALSEC);
 
 	iowrite32(alrm->enabled ? 0 : BM_AMR_OFF, priv->iobase + HW_AMR);
-	spin_unlock_irqrestore(&priv->lock, irq_flags);
 
 	return 0;
 }
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
