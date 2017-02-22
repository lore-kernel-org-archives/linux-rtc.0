Return-Path: <rtc-linux+bncBDXMLNOH5ANRBW67WPCQKGQEFK27O3Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id d63si1364519pfe.2.2017.02.21.17.56.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Feb 2017 17:56:43 -0800 (PST)
Date: Wed, 22 Feb 2017 02:56:34 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Tony Lindgren <tony@atomide.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCHv2] rtc: cpcap: new rtc driver
Message-ID: <20170222015634.ugadzezywlrjduyx@earth>
References: <20170220073535.27393-1-sre@kernel.org>
 <20170221061650.12636-1-sre@kernel.org>
 <20170221235212.hik3whcytw6xyevd@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6upy4xnfm43lqc6l"
In-Reply-To: <20170221235212.hik3whcytw6xyevd@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--6upy4xnfm43lqc6l
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Alexandre,

On Wed, Feb 22, 2017 at 12:52:12AM +0100, Alexandre Belloni wrote:
> The patch has a few checkpatch issues. Some of those should really be
> fixed. Can you do that?

of course.

> Else, it is mostly fine, a few comments below.
> 
> On 21/02/2017 at 07:16:50 +0100, Sebastian Reichel wrote:
> > +static int cpcap_rtc_set_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct cpcap_rtc *rtc;
> > +	struct cpcap_time cpcap_tm;
> > +	int ret = 0;
> > +
> > +	rtc = dev_get_drvdata(dev);
> > +
> > +	rtc2cpcap_time(&cpcap_tm, tm);
> > +
> > +	if (rtc->alarm_enabled)
> > +		disable_irq(rtc->alarm_irq);
> > +	if (rtc->update_enabled)
> > +		disable_irq(rtc->update_irq);
> > +
> > +	if (rtc->vendor == CPCAP_VENDOR_ST) {
> > +		/* The TOD1 and TOD2 registers MUST be written in this order
> > +		 * for the change to properly set. */
> 
> Does this mean there is a race condition?

The logic (incl. comments) in this section are from the vendor
kernel driver and there is no documentation for CPCAP as far as
I know. I don't know if the hardware has logic to prevent a race
condition for the cpcap_tm.tod1 == 255 case.

> > +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_TOD1,
> > +					  TOD1_MASK, cpcap_tm.tod1);
> > +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_TOD2,
> > +					  TOD2_MASK, cpcap_tm.tod2);
> > +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_DAY,
> > +					  DAY_MASK, cpcap_tm.day);
> > +	} else {
> > +		/* Clearing the upper lower 8 bits of the TOD guarantees that
> > +		 * the upper half of TOD (TOD2) will not increment for 0xFF RTC
> > +		 * ticks (255 seconds).  During this time we can safely write
> > +		 * to DAY, TOD2, then TOD1 (in that order) and expect RTC to be
> > +		 * synchronized to the exact time requested upon the final write
> > +		 * to TOD1. */
> > +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_TOD1,
> > +					  TOD1_MASK, 0);
> > +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_DAY,
> > +					  DAY_MASK, cpcap_tm.day);
> > +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_TOD2,
> > +					  TOD2_MASK, cpcap_tm.tod2);
> > +		ret |= regmap_update_bits(rtc->regmap, CPCAP_REG_TOD1,
> > +					  TOD1_MASK, cpcap_tm.tod1);
> > +	}
> > +
> 
> > +	err = cpcap_get_vendor(dev, rtc->regmap, &rtc->vendor);
> I think this means it depends on the mfd tree.

Yes, but cpcap_get_vendor should get into mainline with the
4.11 mfd pull request. So if you base your 4.12 for-next tree
on 4.11-rc1 everything should be fine.

> > +	if (err)
> > +		return err;
> > +
> > +	rtc->alarm_irq= platform_get_irq(pdev, 0);
> > +	err = devm_request_threaded_irq(dev, rtc->alarm_irq, NULL,
> > +					cpcap_rtc_alarm_irq, IRQ_NONE,
> > +					"rtc_alarm", rtc);
> > +	if (err) {
> > +		dev_err(dev, "Could not request alarm irq: %d\n", err);
> > +		return err;
> > +	}
> > +	disable_irq(rtc->alarm_irq);
> > +
> > +	rtc->update_irq= platform_get_irq(pdev, 1);
> > +	err = devm_request_threaded_irq(dev, rtc->update_irq, NULL,
> > +					cpcap_rtc_update_irq, IRQ_NONE,
> > +					"rtc_1hz", rtc);

> I don't think this IRQ is actually useful. It doesn't really harm but
> the tests should pass without it.

Yes. RTC works perfectly fine with just the alarm irq. It also
works perfectly fine with just the 1 Hz irq (except for wakeup).

I would like to keep the irq in the driver, so that it's explicitly
disabled. On Droid 4 mainline kernel is booted via kexec from
Android (AKA bootloader) and Motorola's Android kernel uses the
1 Hz IRQ for some proprietary "secure clock daemon".

I will add a comment.

> > +	if (err) {
> > +		dev_err(dev, "Could not request update irq: %d\n", err);
> > +		return err;
> > +	}
> > +	disable_irq(rtc->update_irq);
> > +
> > +	err = device_init_wakeup(dev, 1);
> 
> If you use device_init_wakeup, I think it needs to be called before
> devm_rtc_device_register() to properly work.

I successfully tested wakeup before sending this. But in case your 
prefer it to be called before registering the RTC I can move the
call accordingly.

-- Sebastian

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--6upy4xnfm43lqc6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlis79AACgkQ2O7X88g7
+poybxAApsMHj5rjw3oZVsQ+N7AjTVDd/SwT8nwC88SgcIHjzjYStjnhAAry4oun
0Tbg0aiDUCL3ldoLgvadWUSx2BaNVRgG9Ow6MUXe8rKKrlE22OPuebKqqw2fuRBH
SA5w4mJ7R62G0+F6WpOJU70pOdHJ9q1tLoTswN+xa/UH3XJXL9qpfdYEvnCtxrav
bR6Ibtwsg7FhXtp9wMTDsInptzruEzcMU50gvxJ5kEnRzz2wlOCT80VtG4D1fK3B
2WYRffDnV79XQUFDQkf1gF3CCCRbs6fQjj7Q+27aTqe9RQKiZAcPyVYOP90Iwr/Y
8W/fkjXK6TeEzKJSN1CU8h16PhCyuu6LC5vH+sVuDkGO6S6pltqhYNprwJqrmmBi
49ie8AcIXlnEIgO23Ea4ZJ0X/PSmh4VeIdDDCOy+vbkVnSk3vpsAK7diwyaAjoPy
OMayqmGeZl92rvzPX7iDLqHkGjKRyGfNHHLPhAG9A1jJ2MA7ZJhrLJtlbcnPFUBx
MpwbSTX5eOKf8HMnU8O1izCknqHzseO4ZEjsTakpSZIgUs8X+GZcQZZSLrltglBB
3xNZbD5kRz/uUHtgPFTI7qIt17SgOBMYwHELdmpfZNV4yHzPXoDl0fuc3n2V9t3+
HJKFoCKunY0nRcgnysfG6/Df8LXmRvNr1CkEV8CpNiQ3Hp/GMo4=
=IYr/
-----END PGP SIGNATURE-----

--6upy4xnfm43lqc6l--
