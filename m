Return-Path: <SRS0=6w/U=QT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4870FC282C4
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 23:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D7C222C2
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 23:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfBLXKg (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:10:36 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:36859 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbfBLXKf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 12 Feb 2019 18:10:35 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E6D2F240003;
        Tue, 12 Feb 2019 23:10:33 +0000 (UTC)
Date:   Wed, 13 Feb 2019 00:10:33 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v3 3/4] rtc: isl1208: Add new style nvmem support to
 driver
Message-ID: <20190212231033.GE10129@piout.net>
References: <20190212023225.2710-1-tpiepho@impinj.com>
 <20190212023225.2710-3-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212023225.2710-3-tpiepho@impinj.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 12/02/2019 02:34:05+0000, Trent Piepho wrote:
> Add support for the RTC's NVRAM using the standard nvmem support that is
> part of the Linux RTC framework.
> 
> This driver already has a sysfs attribute that provides access to the
> RTC's NVRAM as a single 16-bit value.  Some chips have more than two
> bytes of NVRAM, so this will not work for them.  It's also non-standard.
> 
> This sysfs attribute is left in for backward compatibility, but will only
> be able to read the first two bytes of NVRAM.  The nvmem interface will
> allow access to all NVRAM, e.g. eight bytes on the isl1218.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  drivers/rtc/rtc-isl1208.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
