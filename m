Return-Path: <rtc-linux+bncBDS7HNEFSALRB26C3OUQKGQEMIY3DYA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k2si219581wif.0.2015.04.21.16.46.50
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Apr 2015 16:46:50 -0700 (PDT)
Date: Wed, 22 Apr 2015 01:46:50 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Juergen Borleis <jbe@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	kernel@pengutronix.de, Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org,
	Robert Schwebel <rsc@pengutronix.de>
Subject: Re: [rtc-linux] [PATCH 2/5] RTC/i.MX/DryIce: add the unit recovery code
Message-ID: <20150421234649.GG8539@piout.net>
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
 <1429002716-19821-3-git-send-email-jbe@pengutronix.de>
 <20150421231411.GC8539@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150421231411.GC8539@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 22/04/2015 at 01:14:11 +0200, Alexandre Belloni wrote :
> > +	sec = __raw_readl(imxdi->ioaddr + DTCMR);
> > +	if (sec != 0)
> > +		dev_warn(&imxdi->pdev->dev,
> > +			"The security violation has happend at %u seconds\n",
> 
> Further improvement for this driver: use both DTCMR and DTCLR to be year
> 2038 proof

Please forget that comment I just realized that seconds were counted in
the most significant part...


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
