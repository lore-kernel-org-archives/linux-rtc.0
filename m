Return-Path: <rtc-linux+bncBCC6ZWOPXENRBL5S5CUQKGQEK76TE3I@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:6f8:1178:4:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id q10si92886wiz.0.2015.04.24.03.21.34
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 Apr 2015 03:21:34 -0700 (PDT)
From: Juergen Borleis <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [rtc-linux] [PATCH 2/5] RTC/i.MX/DryIce: add the unit recovery code
Date: Fri, 24 Apr 2015 12:24:02 +0200
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org,
 Robert Schwebel <rsc@pengutronix.de>,
 kernel@pengutronix.de
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de> <1429002716-19821-3-git-send-email-jbe@pengutronix.de> <20150421231411.GC8539@piout.net>
In-Reply-To: <20150421231411.GC8539@piout.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201504241224.02705.jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

On Wednesday 22 April 2015 01:14:11 Alexandre Belloni wrote:
> On 14/04/2015 at 11:11:53 +0200, Juergen Borleis wrote :
> > This code is requiered to recover the unit from a security violation.
>
>       required ^

Sure :)

> > [...]
> > +/* do a write into the unit without interrupt support */
> > +static void di_write_busy_wait(const struct imxdi_dev *imxdi, u32 val,
> > +								unsigned reg)
>
> Alignment should match the open parenthesis, please fix all occurrences
> in your patch.

Okay.

> > +{
> > +	/* do the register write */
> > +	__raw_writel(val, imxdi->ioaddr + reg);
> > +
> > +	/*
> > +	 * now it takes four 32,768 kHz clock cycles to take
> > +	 * the change into effect =3D 122 us
> > +	 */
> > +	udelay(200);
>
> As the requirement is not that critical, you may want to use usleep_range=
()

Good point. Will change it.

> > +}
> > +
> > +static void di_report_tamper_info(struct imxdi_dev *imxdi,  u32 dsr)
> > +{
> > +	u32 dtcr;
> > +
> > +	dtcr =3D __raw_readl(imxdi->ioaddr + DTCR);
> > +
> > +	dev_emerg(&imxdi->pdev->dev, "!! DryIce tamper event detected !!\n");
> > +	/* the following flags force a transition into the "FAILURE STATE" */
> > +	if (dsr & DSR_VTD) {
> > +		dev_emerg(&imxdi->pdev->dev, "!! Voltage Tamper event\n");
> > +		if (!(dtcr & DTCR_VTE))
> > +			dev_emerg(&imxdi->pdev->dev,
> > +				"!! But Voltage Tamper detection wasn't enabled. False positive?\n=
");
>
> I'm not sure about prefixing all the messages with "!! ". dev_emerg()
> seems important enough to be noticed.
> I would remove " False positive?". What about
> 		dev_emerg(&imxdi->pdev->dev,
> 			  "%sVoltage Tamper event\n",
> 			  (dtcr & DTCR_VTE) ? "" : "Spurious ");

"spurious" sounds better. And I will change the messages.

> [...]
> > +static void di_what_is_to_be_done(struct imxdi_dev *imxdi,
> > +						const char *power_supply)
> > +{
> > +	dev_emerg(&imxdi->pdev->dev, " Please cycle the %s power supply in or=
der to get the DryIce unit working again\n",
>
>             remove that heading space ^

Yes.

> I would also explain that the RTC is part of the DryIce unit.

Within this message? Makes sense. Will do so.

> [...]
> > +			sec);
> > +	/*
> > +	 * the timer cannot be set/modified if
> > +	 * - the TCHL or TCSL bit is set in DCR
> > +	 */
> > +	dcr =3D __raw_readl(imxdi->ioaddr + DCR);
> > +	if (!(dcr & DCR_TCE)) {
> > +		if (dcr & DCR_TCHL) {
> > +			/* we are out of luck */
> > +			di_what_is_to_be_done(imxdi, "battery");
> > +			return -ENODEV;
> > +		}
> > +		if (dcr & DCR_TCSL) {
> > +			di_what_is_to_be_done(imxdi, "main");
> > +			return -ENODEV;
> > +		}
> > +
>
> Unnecessary blank line

Ups. Made accidentally.

> [...]
> > +	/* success? */
> > +	dsr =3D __raw_readl(imxdi->ioaddr + DSR);
> > +	if (dsr & DSR_SVF) {
> > +		dev_crit(&imxdi->pdev->dev,
> > +			"Cannot clear the security violation flag. We are ending up in an  =
endless loop!\n");
> > +		/* last resourt */=20
>
>                  resort ^

=2EoO(note to myself: update dictionary...)

> [...]
> > @@ -498,44 +793,6 @@ static int __init dryice_rtc_probe(struct platform=
_device *pdev) goto err;
> >  	}
> >
> > -	/* put dryice into valid state */
> > -	if (__raw_readl(imxdi->ioaddr + DSR) & DSR_NVF) {
> > -		rc =3D di_write_wait(imxdi, DSR_NVF | DSR_SVF, DSR);
>
> Multiple writes have switched from di_write_wait() which is checking
> for a write error to di_write_busy_wait() which is not doing that check
> is waiting 200us enough to ensure that the write has been done?

Each write requires four 32 kHz clock cycles. So the 200 us should be enoug=
h.
But I will take a closer look for what have to be really done in the case of
an access error.

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Borleis =A0 =A0 =A0 =A0 =A0 =A0 |
Industrial Linux Solutions               =A0 =A0 =A0| http://www.pengutroni=
x.de/  |
