Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE1EB64D7
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Jun 2023 21:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjFMV06 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 13 Jun 2023 17:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFMV05 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 13 Jun 2023 17:26:57 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C614173C;
        Tue, 13 Jun 2023 14:26:53 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686691612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjZCe4TrlpXSYUUbagVQDBLP7aBDJF+vIKC3en79nPo=;
        b=pKDOX8HkYiifDAB1XriX5mIBW5Jz9sucTkoPOBmTln+QszEhusmswpdySTBA97iXRfsGBf
        sbZCJH+832cgP7WciP76y3ADpuYljAlsCGBghvKvcr48hW9nis7qUFDVCaImlVBb1JzyzO
        uVzuEGgtnX2+vU+h0Gm9ZEK9kpR4EGvLINJSGl8OzggbkfHLwJLBmaMkAT4jcAOXGjXQsy
        muI1LIIJXUhIytwDFNoycJZTaaKP6kobo/tsX+eqMw/gAzZ73cRGDqSBWl6r8TDEANIOEr
        JnDhxiOWSdFgeimQO5vJVBjsSbXz5ujqmew0nD1tgEIuKtqgy4YiwT2Xz2u1FA==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 029941C0002;
        Tue, 13 Jun 2023 21:26:51 +0000 (UTC)
Date:   Tue, 13 Jun 2023 23:26:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] rtc: isl12022: implement RTC_VL_READ ioctl
Message-ID: <20230613212651c8770218@mail.local>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-6-linux@rasmusvillemoes.dk>
 <ZIiJWKBFojAcNCkA@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIiJWKBFojAcNCkA@smile.fi.intel.com>
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 13/06/2023 18:20:56+0300, Andy Shevchenko wrote:
> On Tue, Jun 13, 2023 at 03:00:07PM +0200, Rasmus Villemoes wrote:
> > Hook up support for reading the values of the SR_LBAT85 and SR_LBAT75
> > bits. Translate the former to "battery low", and the latter to
> > "battery empty or not-present".
> 
> A couple of nit-picks below.
> 
> ...
> 
> > +static int isl12022_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
> > +{
> > +	struct regmap *regmap = dev_get_drvdata(dev);
> > +	u32 user = 0, val;
> 
> This assignment can be done in the actual case below.
> 
> > +	int ret;
> > +
> > +	switch (cmd) {
> > +	case RTC_VL_READ:
> > +		ret = regmap_read(regmap, ISL12022_REG_SR, &val);
> > +		if (ret < 0)
> 
> I always feel uneasy with ' < 0' — Does positive error makes sense?
> Is it even possible? OTOH if the entire driver uses this idiom...
> oh well, let's make it consistent.
> 

/**
 * regmap_read() - Read a value from a single register
 *
 * @map: Register map to read from
 * @reg: Register to be read from
 * @val: Pointer to store read value
 *
 * A value of zero will be returned on success, a negative errno will
 * be returned in error cases.
 */

> > +			return ret;
> 
> 		user = 0;
> 
> The rationale to avoid potential mistakes in the future in case this function
> will be expanded and user will be re-used.
> 
> > +		if (val & ISL12022_SR_LBAT85)
> > +			user |= RTC_VL_BACKUP_LOW;
> > +
> > +		if (val & ISL12022_SR_LBAT75)
> > +			user |= RTC_VL_BACKUP_EMPTY;
> > +
> > +		return put_user(user, (u32 __user *)arg);
> > +
> > +	default:
> > +		return -ENOIOCTLCMD;
> > +	}
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
