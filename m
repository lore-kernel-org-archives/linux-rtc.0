Return-Path: <SRS0=37S+=P6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB189C282C3
	for <linux-rtc@archiver.kernel.org>; Tue, 22 Jan 2019 17:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99A821019
	for <linux-rtc@archiver.kernel.org>; Tue, 22 Jan 2019 17:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbfAVRfv (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:35:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45012 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfAVRfv (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 22 Jan 2019 12:35:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E792C2078F; Tue, 22 Jan 2019 18:35:48 +0100 (CET)
Received: from localhost (unknown [80.12.58.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 82DE1206A6;
        Tue, 22 Jan 2019 18:35:48 +0100 (CET)
Date:   Tue, 22 Jan 2019 18:35:48 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2] rtc: s3c: Rewrite clock handling
Message-ID: <20190122173548.GB16702@piout.net>
References: <CGME20190121110938eucas1p2e008ce6dabb0e5c62fdac19dc1491463@eucas1p2.samsung.com>
 <20190121110930.8290-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121110930.8290-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 21/01/2019 12:09:30+0100, Marek Szyprowski wrote:
> s3c_rtc_enable/disable_clk() functions were designed to be called multiple
> times without reference counting, because they were initially only used in
> alarm setting/clearing functions, which can be called both when alarm is
> already set or not. Later however, calls to those functions have been added to
> other places in the driver - like time and /proc reading callbacks, what
> results in broken alarm if any of such events happens after the alarm has
> been set. Fix this by simplifying s3c_rtc_enable/disable_clk() functions
> to rely on proper reference counting in clock core and move alarm enable
> counter to s3c_rtc_setaie() function.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - simplified code as suggested by Krzysztof
> ---
>  drivers/rtc/rtc-s3c.c | 74 ++++++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 43 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
