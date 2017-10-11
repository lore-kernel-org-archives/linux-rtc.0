Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41344 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdJKVrl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 11 Oct 2017 17:47:41 -0400
Date: Wed, 11 Oct 2017 22:47:32 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: clarify the RTC offset correction
Message-ID: <20171011214732.GW20805@n2100.armlinux.org.uk>
References: <E1dxsS5-0006RD-Sy@rmk-PC.armlinux.org.uk>
 <20171003133158.db4eibi6xqdtvbxg@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171003133158.db4eibi6xqdtvbxg@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, Oct 03, 2017 at 03:31:58PM +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 29/09/2017 at 11:23:25 +0100, Russell King wrote:
> > The RTC offset correction documentation is not very clear about the
> > exact relationship between "offset" and the effect it has on the RTC.
> > Supplement the documentation with an equation giving the relationship.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/rtc/interface.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> > index 8cec9a02c0b8..045e0a72d14b 100644
> > --- a/drivers/rtc/interface.c
> > +++ b/drivers/rtc/interface.c
> > @@ -1004,6 +1004,10 @@ int rtc_read_offset(struct rtc_device *rtc, long *offset)
> >   * to compensate for differences in the actual clock rate due to temperature,
> >   * the crystal, capacitor, etc.
> >   *
> > + * The adjustment applied is as follows:
> > + *   t = t0 * (1 + offset * 1e-9)
> > + * where t0 is the measured length of 1 RTC second with offset = 0
> > + *
> 
> More documentation is available in Documentation/rtc.txt. Maybe it is
> worth having the formula in both.

That sounds like a nightmare - stuff should be documented in detail in
one place and only one place, otherwise we risk the two sets of identical
documentation going out of sync.  A better idea would be to reference the
detailed documentation - which I guess would be easier if rtc.txt were
converted to a .rst file?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
