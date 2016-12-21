Return-Path: <rtc-linux+bncBAABBSMW5TBAKGQE4BFAK6I@googlegroups.com>
Received: from botnar.kaiser.cx (botnar.kaiser.cx. [176.28.20.183])
        by gmr-mx.google.com with ESMTPS id 75si7054wme.3.2016.12.21.15.07.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 21 Dec 2016 15:07:53 -0800 (PST)
Date: Thu, 22 Dec 2016 00:06:38 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Juergen Borleis <jbe@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2] rtc: imxdi: use the security violation interrupt
Message-ID: <20161221230638.GA12514@reykholt.kaiser.cx>
References: <1479560614-19293-1-git-send-email-martin@kaiser.cx>
 <1482187289-19272-1-git-send-email-martin@kaiser.cx>
 <1482225821.2293.43.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1482225821.2293.43.camel@pengutronix.de>
Sender: "Martin Kaiser,,," <martin@reykholt.kaiser.cx>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Lucas,

thanks for taking the time to review my patch.

Thus wrote Lucas Stach (l.stach@pengutronix.de):

> > diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
> > index 67b56b8..ec6077a0 100644
> > --- a/drivers/rtc/rtc-imxdi.c
> > +++ b/drivers/rtc/rtc-imxdi.c
> > @@ -109,6 +109,7 @@
> >   * @rtc: pointer to rtc struct
> >   * @ioaddr: IO registers pointer
> >   * @irq: dryice normal interrupt
> > + * @sec_irq: dryice security violation interrupt

> This isn't used outside the probe routine, so doesn't need to be saved
> in the driver data.

The same goes for imxdi->irq, I made this a local variable as well.

> > +	rc = devm_request_irq(&pdev->dev, imxdi->sec_irq, dryice_sec_irq,
> > +			IRQF_SHARED, pdev->name, imxdi);
> > +	if (rc) {
> > +		dev_warn(&pdev->dev, "security violation interrupt not available.\n");
> > +		/* this is not an error, see above */
> > +	}
> > +
> Please just fold this into the "if (rc > 0)" path above.

Are you sure that this would be correct?

My understanding is that we should mask the interrupts by writing 0 into
DIER and set the DryIce to a sane state in di_handle_state() before we
install interrupt handlers.

Best regards,
Martin

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
