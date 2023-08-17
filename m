Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13485C2FC0E
	for <linux-rtc@archiver.kernel.org>; Thu, 17 Aug 2023 08:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbjHQISP (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 17 Aug 2023 04:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348801AbjHQISE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 17 Aug 2023 04:18:04 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A3F2112;
        Thu, 17 Aug 2023 01:18:01 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E11E71BF207;
        Thu, 17 Aug 2023 08:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692260280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u/A8C7JBQ738fk13Qubbm4ibqlz5kqfVpXbbymUEvk8=;
        b=RICAyUmMh+wvPzpu5W9jDSMnSKVGCFq0pW2lkaPyNUmC+VA7p85twGES0tEY3oxJn3mROl
        7tqtK2KUjlzceKXNK63s/SwUw7W4uh5AhjPfSEPdLBt4Vn+S5vq9uBdtyyTiCNosPfR4Y7
        T0SwTwPjBuvdZPdXGwKHQzSHfZRd92Hh2o6FdDgCoquZTiwsSF9J2n3dlpN23LOdYHFQnM
        M2hZ1YdJiG+AdxpI1l32EBxz0hgOt2hr13FUMzzbYCA8DaWbAlq9JuoMzWCW0aKiCW26aP
        PgKqN5FfghqEH1OHVcYnn+RZkra3I2aB/YgB0Bi/BvZzc1mw/plUl5v/f3PdZA==
Date:   Thu, 17 Aug 2023 10:17:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf85363: Allow to wake up system without IRQ
Message-ID: <202308170817599c17a369@mail.local>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.eeedf5db-4013-4c3b-be1c-1121df58f897@emailsignatures365.codetwo.com>
 <20230502055458.11004-1-mike.looijmans@topic.nl>
 <202308162140170c067ce7@mail.local>
 <ec2d7ef3-3dcc-aebb-1a4f-c2e01a09f750@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2d7ef3-3dcc-aebb-1a4f-c2e01a09f750@topic.nl>
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 17/08/2023 07:42:25+0200, Mike Looijmans wrote:
> On 16-08-2023 23:40, Alexandre Belloni wrote:
> > Hello Mike,
> > 
> > Sorry for the very late review, there is a small change that is needed:
> 
> Better late than never
> 
> > 
> > On 02/05/2023 07:54:58+0200, Mike Looijmans wrote:
> > > When wakeup-source is set in the devicetree, set up the device for
> > > using the output as interrupt instead of clock. This is similar to
> > > how other RTC devices handle this.
> > > 
> > > This allows the clock chip to turn on the board when wired to do
> > > so in hardware.
> > > 
> > > Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> > > 
> > > ---
> > > 
> > >   drivers/rtc/rtc-pcf85363.c | 17 ++++++++++-------
> > >   1 file changed, 10 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> > > index 8958eadf1c3e..b1543bcdc530 100644
> > > --- a/drivers/rtc/rtc-pcf85363.c
> > > +++ b/drivers/rtc/rtc-pcf85363.c
> > > @@ -434,23 +434,26 @@ static int pcf85363_probe(struct i2c_client *client)
> > >   	pcf85363->rtc->range_max = RTC_TIMESTAMP_END_2099;
> > >   	clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
> > > +	if (client->irq > 0 || device_property_read_bool(&client->dev,
> > > +							 "wakeup-source")) {
> > > +		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
> > > +		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
> > > +				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
> > > +		device_init_wakeup(&client->dev, true);
> > > +		set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
> > 
> > This should not be done when devm_request_threaded_irq fails.
> 
> Yeah, easiest would be to just clear the feature flag when that happens.

My comment was also for device_init_wakeup(&client->dev, true);. I think
the easiest would be to move this block later on and set client->irq to
0 when devm_request_threaded_irq fails.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
