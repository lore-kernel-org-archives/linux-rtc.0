Return-Path: <SRS0=sG8A=BF=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA21C433DF
	for <linux-rtc@archiver.kernel.org>; Sun, 26 Jul 2020 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D35206D8
	for <linux-rtc@archiver.kernel.org>; Sun, 26 Jul 2020 19:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGZTkL (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:40:11 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:41355 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGZTkK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 26 Jul 2020 15:40:10 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E899A240002;
        Sun, 26 Jul 2020 19:40:07 +0000 (UTC)
Date:   Sun, 26 Jul 2020 21:40:07 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "Kevin P. Fleming" <kevin+linux@km6g.us>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH 1/3 v3] dt-bindings: abx80x: Add autocal-filter property
Message-ID: <20200726193842.GC4073@piout.net>
References: <20200615105113.57770-1-kevin+linux@km6g.us>
 <20200713183906.GA510880@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713183906.GA510880@bogus>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Rob,

On 13/07/2020 12:39:06-0600, Rob Herring wrote:
> On Mon, Jun 15, 2020 at 06:51:11AM -0400, Kevin P. Fleming wrote:
> > Add a property to allow control of the autocalibration filter
> > capacitor.
> > 
> > Signed-off-by: Kevin P. Fleming <kevin+linux@km6g.us>
> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > To: linux-rtc@vger.kernel.org
> > To: devicetree@vger.kernel.org
> > ---
> > v3: corrected whitespace
> >  Documentation/devicetree/bindings/rtc/abracon,abx80x.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
> > index 2405e35a1bc0f..1b606e33d1a83 100644
> > --- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
> > +++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
> > @@ -29,3 +29,11 @@ and valid to enable charging:
> >   - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
> >   - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables the output
> >                            resistor, the other values are in kOhm.
> > +
> > +All of the devices can have a 47pf capacitor attached to increase the
> > +autocalibration accuracy of their RC oscillators. To enable or disable usage
> > +of the capacitor the following property can be defined:
> > +
> > + - "abracon,autocal-filter": should be <0> or <1>. 0 indicates that there
> > +                             is no capacitor attached, 1 indicates that there
> > +                             is a capacitor attached.
> 
> What does not present mean? If you don't have a defined meaning (such 
> as maintain the default/bootloader initialized setting), then make this 
> boolean.

We discussed that on the previous revision. Not present means keeping
the current value. Like most RTC registers, this is battery backed and
it is expected to persist across reboots. If it has ever been
initialized to a value, (e.g. by the bootloader), then we need a way to
have the driver not change it.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
