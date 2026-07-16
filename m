Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0467726159E
	for <linux-rtc@vger.kernel.org>; Thu, 16 Jul 2026 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215874; cv=none; b=UR3wUrcEr0+cuQnMNZdOMh7ugdbpwRvpIz96hppOsaPFPIwPprMrHNyqeVoh6Wmoh3j74DKLkBXmIVo/MYVrBpQXlH0u1gZzfS+B0eUVlIIYYyS6AzqsCQ3K+9H49ft2Ri/VdpDS/6hzGM/ZCj6IqLJro1c/xaSPTJEZbSI8xAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215874; c=relaxed/simple;
	bh=X5zUvxbRmUaYFKtcEZAwdj17ik1w/+Kt+iS+eYvTFsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv90sQelYccIB1vME9e+bk1CZ52zEljoa4ITSFq6Zh+XTrsB1JzG72Vi7w2NhB7HC6x9pD/i9DKwEfXL5cU4aUxxl61+VrWJ5DlNqM/5dt3QRIzu26nTEOHc42Q/Amj/o03yVvtDTJ0PuIYTxpR7u8uOt4eWFp3xxFYNiHovtF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kNrNUcS+; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kNrNUcS+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0B1124E40DFB
	for <linux-rtc@vger.kernel.org>; Thu, 16 Jul 2026 15:22:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D1A20602B8;
	Thu, 16 Jul 2026 15:22:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50B9311BD3D1F;
	Thu, 16 Jul 2026 17:22:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784215356; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YaPX/D630TdemNvpNqZNhOT8i02uW0eFRaBQFxknDoY=;
	b=kNrNUcS+VAmDK8hrmCuqGfPRT2IQAVppZu2OVeQT0/Q5yfZ4W+udvYJvc0QY6JZoorJGPK
	UCtZ0GTztUfa0U0kIAHrGmaNp9JF6BK7ERD8XHUXK0+kVNbnezbR4136vXsUvFQ320baBQ
	jy9eHmly1gR18XM/4mkK9Oq2jn6ub1K/kwHkw8WUHQ83y2mKTGar7yItxISB3u49dyo8eh
	iZgsxU2Pe6GA2gMjXxmj4/8zB/h96p11eBOxw4Z1Sx+1hOUuAx0K3NZDKK4XwELRgSwzQS
	/ITRolDCyw6M8zYZ/Gb4+CFT6EyRadE+Su0Gq0VHlZiScQMxBBcpwEMobc9b7A==
Date: Thu, 16 Jul 2026 17:22:33 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com
Subject: Re: [PATCH] rtc: pcf85363: Fix phantom device registration on
 missing hardware
Message-ID: <2026071615223327bdc046@mail.local>
References: <20260716125142.1801599-1-chou.cosmo@gmail.com>
 <20260716125617ee5cdf09@mail.local>
 <CAOeEDysWcPR+BdjrFGE89dwsQNWFG1ihf0q4kiWzRHVRzOtcyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOeEDysWcPR+BdjrFGE89dwsQNWFG1ihf0q4kiWzRHVRzOtcyA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 16/07/2026 22:56:04+0800, Cosmo Chou wrote:
> On Thu, Jul 16, 2026 at 8:56 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 16/07/2026 20:51:42+0800, Cosmo Chou wrote:
> > > During probe, pcf85363_load_capacitance() writes the oscillator load
> > > capacitance configuration to the device. However, if the device is
> > > not physically present on the bus (returning -ENXIO), the driver
> > > only emits a warning and continues to execute the probe.
> > >
> > > This results in the successful registration of a phantom RTC device
> > > via devm_rtc_register_device() and its associated nvmem regions.
> > > Consequently, userspace may attempt to bind to a non-functional
> > > /dev/rtc node.
> > >
> > > Propagate the I2C error back to the driver core using dev_err_probe()
> > > to properly abort the probe and prevent phantom device registration.
> > >
> >
> > No, there is no point in this, simply remove the RTC node from you
> > device tree.
> >
> 
> Hi Alexandre,
> 
> You are right, fixing the DT is the correct solution for missing
> hardware. My commit message was misleading.
> 
> However, the current code ignores actual I2C transport errors (e.g.,
> -ENXIO due to physical bus issues) from pcf85363_load_capacitance()
> and continues probing.
> 
> Should I send a v2 with an updated commit message focusing solely on
> properly handling these transport errors?

Then you should add error checking to all the regmap calls in probe()

> 
> Thanks,
> Cosmo
> 
> > > Fixes: fd9a6a13949a ("rtc: pcf85363: add support for the quartz-load-femtofarads property")
> > > Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> > > ---
> > >  drivers/rtc/rtc-pcf85363.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> > > index 540042b9eec8..5612330aff40 100644
> > > --- a/drivers/rtc/rtc-pcf85363.c
> > > +++ b/drivers/rtc/rtc-pcf85363.c
> > > @@ -426,8 +426,8 @@ static int pcf85363_probe(struct i2c_client *client)
> > >
> > >       err = pcf85363_load_capacitance(pcf85363, client->dev.of_node);
> > >       if (err < 0)
> > > -             dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
> > > -                      err);
> > > +             return dev_err_probe(&client->dev, err,
> > > +                                  "failed to set xtal load capacitance\n");
> > >
> > >       pcf85363->rtc->ops = &rtc_ops;
> > >       pcf85363->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> > > --
> > > 2.43.0
> > >
> >
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
