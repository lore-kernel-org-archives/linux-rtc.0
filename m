Return-Path: <rtc-linux+bncBDQJZJXU2UMBBMELTS7AKGQEUOHMS3Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id r74si2521056wme.3.2016.08.31.09.28.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 09:28:32 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: asm9260: rework locking
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Alessandro Zummo <a.zummo@towertech.it>
References: <20160831161528.11217-1-alexandre.belloni@free-electrons.com>
 <20160831161528.11217-2-alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
From: Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <431964d3-b4d9-b787-297e-a6e89f719194@rempel-privat.de>
Date: Wed, 31 Aug 2016 18:28:11 +0200
MIME-Version: 1.0
In-Reply-To: <20160831161528.11217-2-alexandre.belloni@free-electrons.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BcNNjpaf4iKK9Hfxl8qdpGWBC4EmGE6mB"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BcNNjpaf4iKK9Hfxl8qdpGWBC4EmGE6mB
Content-Type: multipart/mixed; boundary="uMfCtPoVOJU0MaJAik3rtm1rOlv0k04Ws";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Message-ID: <431964d3-b4d9-b787-297e-a6e89f719194@rempel-privat.de>
Subject: Re: [PATCH v2 2/2] rtc: asm9260: rework locking
References: <20160831161528.11217-1-alexandre.belloni@free-electrons.com>
 <20160831161528.11217-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20160831161528.11217-2-alexandre.belloni@free-electrons.com>

--uMfCtPoVOJU0MaJAik3rtm1rOlv0k04Ws
Content-Type: text/plain; charset=UTF-8

Looks ok,

thank you!

Am 31.08.2016 um 18:15 schrieb Alexandre Belloni:
> The rtc-asm9260 driver uses a discrete spinlock (wrongly uninitialized).
> Use the rtc mutex to lock mmio accesses instead.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/rtc-asm9260.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
> index 5219916ce11d..18a93d3e3f93 100644
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
> @@ -122,11 +120,15 @@ static irqreturn_t asm9260_rtc_irq(int irq, void *dev_id)
>  	u32 isr;
>  	unsigned long events = 0;
>  
> +	mutex_lock(&priv->rtc->ops_lock);
>  	isr = ioread32(priv->iobase + HW_CIIR);
> -	if (!isr)
> +	if (!isr) {
> +		mutex_unlock(&priv->rtc->ops_lock);
>  		return IRQ_NONE;
> +	}
>  
>  	iowrite32(0, priv->iobase + HW_CIIR);
> +	mutex_unlock(&priv->rtc->ops_lock);
>  
>  	events |= RTC_AF | RTC_IRQF;
>  
> @@ -139,9 +141,7 @@ static int asm9260_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
>  	u32 ctime0, ctime1, ctime2;
> -	unsigned long irq_flags;
>  
> -	spin_lock_irqsave(&priv->lock, irq_flags);
>  	ctime0 = ioread32(priv->iobase + HW_CTIME0);
>  	ctime1 = ioread32(priv->iobase + HW_CTIME1);
>  	ctime2 = ioread32(priv->iobase + HW_CTIME2);
> @@ -155,7 +155,6 @@ static int asm9260_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  		ctime1 = ioread32(priv->iobase + HW_CTIME1);
>  		ctime2 = ioread32(priv->iobase + HW_CTIME2);
>  	}
> -	spin_unlock_irqrestore(&priv->lock, irq_flags);
>  
>  	tm->tm_sec  = (ctime0 >> BM_CTIME0_SEC_S)  & BM_CTIME0_SEC_M;
>  	tm->tm_min  = (ctime0 >> BM_CTIME0_MIN_S)  & BM_CTIME0_MIN_M;
> @@ -174,9 +173,7 @@ static int asm9260_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int asm9260_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
> -	unsigned long irq_flags;
>  
> -	spin_lock_irqsave(&priv->lock, irq_flags);
>  	/*
>  	 * make sure SEC counter will not flip other counter on write time,
>  	 * real value will be written at the enf of sequence.
> @@ -191,7 +188,6 @@ static int asm9260_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	iowrite32(tm->tm_hour, priv->iobase + HW_HOUR);
>  	iowrite32(tm->tm_min,  priv->iobase + HW_MIN);
>  	iowrite32(tm->tm_sec,  priv->iobase + HW_SEC);
> -	spin_unlock_irqrestore(&priv->lock, irq_flags);
>  
>  	return 0;
>  }
> @@ -199,9 +195,7 @@ static int asm9260_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  static int asm9260_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  {
>  	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
> -	unsigned long irq_flags;
>  
> -	spin_lock_irqsave(&priv->lock, irq_flags);
>  	alrm->time.tm_year = ioread32(priv->iobase + HW_ALYEAR);
>  	alrm->time.tm_mon  = ioread32(priv->iobase + HW_ALMON);
>  	alrm->time.tm_mday = ioread32(priv->iobase + HW_ALDOM);
> @@ -213,7 +207,6 @@ static int asm9260_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  
>  	alrm->enabled = ioread32(priv->iobase + HW_AMR) ? 1 : 0;
>  	alrm->pending = ioread32(priv->iobase + HW_CIIR) ? 1 : 0;
> -	spin_unlock_irqrestore(&priv->lock, irq_flags);
>  
>  	return rtc_valid_tm(&alrm->time);
>  }
> @@ -221,9 +214,7 @@ static int asm9260_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  static int asm9260_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  {
>  	struct asm9260_rtc_priv *priv = dev_get_drvdata(dev);
> -	unsigned long irq_flags;
>  
> -	spin_lock_irqsave(&priv->lock, irq_flags);
>  	iowrite32(alrm->time.tm_year, priv->iobase + HW_ALYEAR);
>  	iowrite32(alrm->time.tm_mon,  priv->iobase + HW_ALMON);
>  	iowrite32(alrm->time.tm_mday, priv->iobase + HW_ALDOM);
> @@ -234,7 +225,6 @@ static int asm9260_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
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

--uMfCtPoVOJU0MaJAik3rtm1rOlv0k04Ws--

--BcNNjpaf4iKK9Hfxl8qdpGWBC4EmGE6mB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlfHBZsACgkQHwImuRkmbWlLdQD/Wa75X11WHVgMyFK24vyrfHia
tspdasuLk5JOC736JUIA/13mQFVUZJsX/D0rzqQ7KxClOzp/I0jB34w+zxEaJjjH
=eo6+
-----END PGP SIGNATURE-----

--BcNNjpaf4iKK9Hfxl8qdpGWBC4EmGE6mB--
