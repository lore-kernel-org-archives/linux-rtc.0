Return-Path: <SRS0=8ZG9=RZ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC7DC43381
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Mar 2019 06:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C5C218E2
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Mar 2019 06:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfCVGMQ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:12:16 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37155 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfCVGMP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 22 Mar 2019 02:12:15 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 712331BF208;
        Fri, 22 Mar 2019 06:12:12 +0000 (UTC)
Date:   Fri, 22 Mar 2019 07:12:07 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 3/3] rtc: sh: set range
Message-ID: <20190322061207.GV29054@piout.net>
References: <20190320113010.8955-1-alexandre.belloni@bootlin.com>
 <20190320113010.8955-3-alexandre.belloni@bootlin.com>
 <CAMuHMdUOigr35gDjDNACkk2L4Cq-HQ=TtBAKGLiAhsmcVPOhSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUOigr35gDjDNACkk2L4Cq-HQ=TtBAKGLiAhsmcVPOhSQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 21/03/2019 11:22:26+0100, Geert Uytterhoeven wrote:
> On Wed, Mar 20, 2019 at 12:30 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > The SH RTC is a BCD RTC with some version having 4 digits for the year.
> >
> > The range for the RTCs with only 2 digits for the year was unfortunately
> > shifted to handle 1999 to 2098.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/include/linux/rtc.h
> > +++ b/include/linux/rtc.h
> > @@ -165,6 +165,7 @@ struct rtc_device {
> >  #define RTC_TIMESTAMP_BEGIN_1900       -2208989361LL /* 1900-01-01 00:00:00 */
> 
> mktime64(1900, 1, 1, 0, 0, 0) = -2208988800 ??
> 
> Is this due to leap seconds, and mktime64() is valid for 1970 and later only?
> 

That's a bug, it seems I didn't use the correct timezone when doing the
calculation. Thanks for spotting that, you can send a patch to correct
it or I can do it.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
