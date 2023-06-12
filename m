Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA18C7EE2F
	for <linux-rtc@archiver.kernel.org>; Mon, 12 Jun 2023 16:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjFLQKr (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 12 Jun 2023 12:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFLQKr (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 12 Jun 2023 12:10:47 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D48710C9;
        Mon, 12 Jun 2023 09:10:43 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686586242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rYcn3RNmCkhTMoTm2euN2KhPgjvs1X0oq7hvMFkzhzM=;
        b=Q0x12Hn0KgaIHzqIKKUftOfcxtwwKuV3aZW/89yjqTkPUOCBiDkmr9OW8lBFgi8kmWuDsW
        eOdLaEHc2z0LCN+txJpzfdk0KREfJQw5GPd5lmc6xqPE42zQOZ0TGHAKowz9T6WKZs2AXp
        W8oLVolX/1d81v5JTk7HBVt4YiAwcWKv4pEJBSQodQ1w5wgpbnNGXhSBkwnoTlemQu7pu3
        FM8vpmLGgrJ9WRs3zQIyl6HOPMxSt6Kj3MVkTZCcwvWyAzec0NhB9ugNt7EbYy6hK7V7Sv
        +WG8QZ9YzS/HaK+xIqIiNRhtaoSwocPpM2bxZY44mEVHMTPFRpdWDrqMjX1Pdg==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A02B60010;
        Mon, 12 Jun 2023 16:10:40 +0000 (UTC)
Date:   Mon, 12 Jun 2023 18:10:40 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] rtc: isl12022: implement RTC_VL_READ and RTC_VL_CLR
 ioctls
Message-ID: <202306121610404abc8cbc@mail.local>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-6-linux@rasmusvillemoes.dk>
 <ZIc+YdUPIAt6L4fi@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIc+YdUPIAt6L4fi@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 12/06/2023 18:48:49+0300, Andy Shevchenko wrote:
> On Mon, Jun 12, 2023 at 01:30:55PM +0200, Rasmus Villemoes wrote:
> > Hook up support for reading the values of the SR_LBAT85 and SR_LBAT75
> > bits. Translate the former to "battery low", and the latter to
> > "battery empty or not-present".
> 
> ...
> 
> > +static int isl12022_read_sr(struct regmap *regmap)
> > +{
> > +	int ret;
> > +	u32 val;
> > +
> > +	ret = regmap_read(regmap, ISL12022_REG_SR, &val);
> > +	if (ret < 0)
> > +		return ret;
> > +	return val;
> 
> Wondering if the bit 31 is in use with this register (note, I haven't checked
> the register width nor datasheet).
> 

register width is in the driver:

static const struct regmap_config regmap_config = {
	.reg_bits = 8,
	.val_bits = 8,
	.use_single_write = true,
};


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
