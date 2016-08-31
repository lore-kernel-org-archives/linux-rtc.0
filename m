Return-Path: <rtc-linux+bncBDQJZJXU2UMBB2PITO7AKGQE6MNZYEQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id p199si2422436wmd.1.2016.08.31.08.14.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 08:14:49 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: asm9260: rework locking
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Alessandro Zummo <a.zummo@towertech.it>
References: <20160831001805.8367-1-alexandre.belloni@free-electrons.com>
 <20160831001805.8367-2-alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
From: Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <5e6bfec7-d5b6-6311-9cab-76d9aa932408@rempel-privat.de>
Date: Wed, 31 Aug 2016 17:14:27 +0200
MIME-Version: 1.0
In-Reply-To: <20160831001805.8367-2-alexandre.belloni@free-electrons.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0OnJIiWKcXMvIWQIDT7SpxNbwpAgtmqt2"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0OnJIiWKcXMvIWQIDT7SpxNbwpAgtmqt2
Content-Type: multipart/mixed; boundary="tVuEpBE5W2U5rBDT1u22dUGlILNmEwTI9";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Message-ID: <5e6bfec7-d5b6-6311-9cab-76d9aa932408@rempel-privat.de>
Subject: Re: [PATCH 2/2] rtc: asm9260: rework locking
References: <20160831001805.8367-1-alexandre.belloni@free-electrons.com>
 <20160831001805.8367-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20160831001805.8367-2-alexandre.belloni@free-electrons.com>

--tVuEpBE5W2U5rBDT1u22dUGlILNmEwTI9
Content-Type: text/plain; charset=UTF-8

Hi

Am 31.08.2016 um 02:18 schrieb Alexandre Belloni:
> The rtc-asm9260 driver uses a discrete spinlock (wrongly uninitialized).
> Use the rtc mutex to lock mmio accesses instead.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/rtc-asm9260.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
> index 5219916ce11d..812f131da694 100644
> --- a/drivers/rtc/rtc-asm9260.c
> +++ b/drivers/rtc/rtc-asm9260.c
> @@ -112,8 +112,6 @@ struct asm9260_rtc_priv {
>  	void __iomem		*iobase;
>  	struct rtc_device	*rtc;
>  	struct clk		*clk;
> -	/* io lock */
> -	spinlock_t		lock;
>  };
>  
>  static irqreturn_t asm9260_rtc_irq(int irq, void *dev_id)
> @@ -122,11 +120,13 @@ static irqreturn_t asm9260_rtc_irq(int irq, void *dev_id)
>  	u32 isr;
>  	unsigned long events = 0;
>  
> +	mutex_lock(&priv->rtc->ops_lock);
>  	isr = ioread32(priv->iobase + HW_CIIR);
>  	if (!isr)
>  		return IRQ_NONE;
>  
>  	iowrite32(0, priv->iobase + HW_CIIR);
> +	mutex_unlock(&priv->rtc->ops_lock);

This means if we have shared or spurious interrupt we will get a
deadlock here?


>  	events |= RTC_AF | RTC_IRQF;
>  
> @@ -139,9 +139,7 @@ static int asm9260_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
>  	u32 ctime0, ctime1, ctime2;
> -	unsigned long irq_flags;
>  
> -	spin_lock_irqsave(&priv->lock, irq_flags);
>  	ctime0 = ioread32(priv->iobase + HW_CTIME0);
>  	ctime1 = ioread32(priv->iobase + HW_CTIME1);
>  	ctime2 = ioread32(priv->iobase + HW_CTIME2);
> @@ -155,7 +153,6 @@ static int asm9260_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  		ctime1 = ioread32(priv->iobase + HW_CTIME1);
>  		ctime2 = ioread32(priv->iobase + HW_CTIME2);
>  	}
> -	spin_unlock_irqrestore(&priv->lock, irq_flags);
>  
>  	tm->tm_sec  = (ctime0 >> BM_CTIME0_SEC_S)  & BM_CTIME0_SEC_M;
>  	tm->tm_min  = (ctime0 >> BM_CTIME0_MIN_S)  & BM_CTIME0_MIN_M;
> @@ -174,9 +171,7 @@ static int asm9260_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int asm9260_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
> -	unsigned long irq_flags;
>  
> -	spin_lock_irqsave(&priv->lock, irq_flags);
>  	/*
>  	 * make sure SEC counter will not flip other counter on write time,
>  	 * real value will be written at the enf of sequence.
> @@ -191,7 +186,6 @@ static int asm9260_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	iowrite32(tm->tm_hour, priv->iobase + HW_HOUR);
>  	iowrite32(tm->tm_min,  priv->iobase + HW_MIN);
>  	iowrite32(tm->tm_sec,  priv->iobase + HW_SEC);
> -	spin_unlock_irqrestore(&priv->lock, irq_flags);
>  
>  	return 0;
>  }
> @@ -199,9 +193,7 @@ static int asm9260_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  static int asm9260_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  {
>  	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
> -	unsigned long irq_flags;
>  
> -	spin_lock_irqsave(&priv->lock, irq_flags);
>  	alrm->time.tm_year = ioread32(priv->iobase + HW_ALYEAR);
>  	alrm->time.tm_mon  = ioread32(priv->iobase + HW_ALMON);
>  	alrm->time.tm_mday = ioread32(priv->iobase + HW_ALDOM);
> @@ -213,7 +205,6 @@ static int asm9260_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  
>  	alrm->enabled = ioread32(priv->iobase + HW_AMR) ? 1 : 0;
>  	alrm->pending = ioread32(priv->iobase + HW_CIIR) ? 1 : 0;
> -	spin_unlock_irqrestore(&priv->lock, irq_flags);
>  
>  	return rtc_valid_tm(&alrm->time);
>  }
> @@ -221,9 +212,7 @@ static int asm9260_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  static int asm9260_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  {
>  	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
> -	unsigned long irq_flags;
>  
> -	spin_lock_irqsave(&priv->lock, irq_flags);
>  	iowrite32(alrm->time.tm_year, priv->iobase + HW_ALYEAR);
>  	iowrite32(alrm->time.tm_mon,  priv->iobase + HW_ALMON);
>  	iowrite32(alrm->time.tm_mday, priv->iobase + HW_ALDOM);
> @@ -234,7 +223,6 @@ static int asm9260_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	iowrite32(alrm->time.tm_sec,  priv->iobase + HW_ALSEC);
>  
>  	iowrite32(alrm->enabled ? 0 : BM_AMR_OFF, priv->iobase + HW_AMR);
> -	spin_unlock_irqrestore(&priv->lock, irq_flags);
>  
>  	return 0;
>  }
> 


-- 
Regards,
Oleksij

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--tVuEpBE5W2U5rBDT1u22dUGlILNmEwTI9--

--0OnJIiWKcXMvIWQIDT7SpxNbwpAgtmqt2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlfG9FMACgkQHwImuRkmbWkEKQD+NWw/r8E+Rqqj/qmlcom1ZrBg
LrWEPloD/7kHQoctbJwA+wUkiIZNXWSRoWtqFMsZ49jICVDZPD98hysYXyhn6bmr
=BAck
-----END PGP SIGNATURE-----

--0OnJIiWKcXMvIWQIDT7SpxNbwpAgtmqt2--
