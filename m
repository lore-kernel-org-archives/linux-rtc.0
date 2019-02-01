Return-Path: <SRS0=fWeB=QI=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2C8C282DA
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Feb 2019 14:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58902086C
	for <linux-rtc@archiver.kernel.org>; Fri,  1 Feb 2019 14:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfBAONL (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:13:11 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:43317 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfBAONL (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 1 Feb 2019 09:13:11 -0500
X-Greylist: delayed 169282 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Feb 2019 09:13:10 EST
Received: from localhost (alyon-652-1-30-254.w109-213.abo.wanadoo.fr [109.213.13.254])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 1A4D1100004;
        Fri,  1 Feb 2019 14:13:07 +0000 (UTC)
Date:   Fri, 1 Feb 2019 15:13:06 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: x1205: Add DT probing support
Message-ID: <20190201141306.GA3289@piout.net>
References: <20190131150642.26289-1-linus.walleij@linaro.org>
 <20190131150642.26289-2-linus.walleij@linaro.org>
 <20190131153012.GA15115@piout.net>
 <CACRpkdZY9jnJMx=oMnmG4Kj+kUmziiJ8D3M85awnAC=jNDt50g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZY9jnJMx=oMnmG4Kj+kUmziiJ8D3M85awnAC=jNDt50g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 01/02/2019 13:22:57+0100, Linus Walleij wrote:
> On Thu, Jan 31, 2019 at 4:30 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > On 31/01/2019 16:06:42+0100, Linus Walleij wrote:
> 
> > > This makes it possible to probe the X1205 RTC from the
> > > device tree. This is needed when adding device tree boot
> > > support for the IXP4xx-based NSLU2 which has this RTC.
> > >
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > >  drivers/rtc/rtc-x1205.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/rtc/rtc-x1205.c b/drivers/rtc/rtc-x1205.c
> > > index f08f18e4fcdf..c2b64c9363da 100644
> > > --- a/drivers/rtc/rtc-x1205.c
> > > +++ b/drivers/rtc/rtc-x1205.c
> > > @@ -673,9 +673,15 @@ static const struct i2c_device_id x1205_id[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, x1205_id);
> > >
> > > +static const struct of_device_id x1205_dt_ids[] = {
> > > +     { .compatible = "xircom,x1205", },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, x1205_dt_ids);
> > > +
> >
> > I think this is not necessary and this will probe without the
> > of_match_table but it doesn't hurt either.
> 
> In the earlier implementations of device tree it was done
> such that the device node would match the i2c name and
> then the device would probe, such that if I in my device
> tree name it:
> 
> x1205@6f {
>     reg = <>;
> };
> 
> Then the core will see match that node name to the i2c
> device name. (I think this goes way back, possibly to the
> earliest Open Firmware.)
> 
> However the DT maintainers have more and more pushed
> for DT nodes to have functional name, so this would then
> be named:
> 
> rtc@6f {
>     reg = <>;
> };
> 
> And then it stops working.
> 
> I think Lee Jones added the compatible probing to a bunch
> of I2C devices for this reason.
> 

Well, that is not what I was referring to. You could use:

rtc@6f {
     compatible = "xircom,x1205";
     reg = <0x6f>;
};

And this would already probe without having an of_device_id table
because the i2c core is matching the compatibles with the i2c_device_id
table.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
