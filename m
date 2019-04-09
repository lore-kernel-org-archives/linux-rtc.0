Return-Path: <SRS0=ZSCd=SL=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFB5C10F0E
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 11:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5669F20883
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 11:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDIL16 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:27:58 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:49761 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfDIL16 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 9 Apr 2019 07:27:58 -0400
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7E269100003;
        Tue,  9 Apr 2019 11:27:56 +0000 (UTC)
Date:   Tue, 9 Apr 2019 13:27:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mastro Gippo <gipmad@gmail.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org
Subject: Re: Infinite loop on edge cases
Message-ID: <20190409112754.GU7480@piout.net>
References: <CADjOgT97-8PM1=Nm+Mk4jw_8vzt3i9KXUohDAkUsptxS7JuU6Q@mail.gmail.com>
 <20190409090119.GT7480@piout.net>
 <CADjOgT-BK2SyoZD76iLj-fYG-7-2G0SvkFC4M6zakQc+7Q3g_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADjOgT-BK2SyoZD76iLj-fYG-7-2G0SvkFC4M6zakQc+7Q3g_w@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 09/04/2019 12:46:20+0200, Mastro Gippo wrote:
> Hi Alexandre,
> thank you for your comments.
> Since failure behaviour is not specified in the Maxim datasheet, the
> gracious way to handle this would be a retry counter, as that would
> also solve the problem of a DS1307 that for some reason doesn't set
> the CH bit (maybe an internal oscillator failure?). A similar erratic
> behavior happened to me once, due to an unstable power supply to the
> RTC.

Ok, I had a closer look at the tissue, the solution here is to not
bother and simply not handle DS1307_BIT_CH, DS1338_BIT_OSF,
DS1340_BIT_nEOSC, DS1340_BIT_OSF, MCP794XX_BIT_VBATEN or
MCP794XX_BIT_ST. they should only be handled in the read_time and
set_time callbacks, were they really matters. I'll send a patch for
that.

> IMHO, I think that a hardware failure and/or a problematic I2C driver
> should not produce an infinite loop - be it fatal or not.

This is correct and this has to be fixed. I must admit I was too quick
and didn't see this was in the probe function.

> I already solved my boot issue with this patch, and I will ship it
> with the devices I sell, but may I ask you what approach would you
> recommend instead of hctosys? I tried looking online for solutions but
> couldn't find an "official" one. I will gladly investigate better
> approaches if available.
> 

Many distributions have initscripts that are using hwclock to set the
system time at boot and save it at shutdown. The kernel is not doing a
good job at setting the system time and saving it for technical and
historical reasons. hctosys and systohc should not be used.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
