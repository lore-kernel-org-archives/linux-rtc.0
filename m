Return-Path: <SRS0=uv83=NZ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F524C43441
	for <linux-rtc@archiver.kernel.org>; Wed, 14 Nov 2018 09:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535172145D
	for <linux-rtc@archiver.kernel.org>; Wed, 14 Nov 2018 09:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535172145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeKNUCN (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:02:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58613 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeKNUCN (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 14 Nov 2018 15:02:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 241C120D83; Wed, 14 Nov 2018 10:59:39 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id EC41320510;
        Wed, 14 Nov 2018 10:59:28 +0100 (CET)
Date:   Wed, 14 Nov 2018 10:59:28 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] rtc: s3c-rtc: Avoid using broken ALMYEAR register
Message-ID: <20181114095928.GW29768@piout.net>
References: <CGME20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6@eucas1p1.samsung.com>
 <20181113113250.15527-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113113250.15527-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 13/11/2018 12:32:50+0100, Marek Szyprowski wrote:
> (RTC,ALM)YEAR registers of Exynos built-in RTC device contains 3 BCD
> characters. s3c-rtc driver uses only 2 lower of them and supports years
> from 2000..2099 range. The third BCD value is typically set to 0, but it
> looks that handling of it is broken in the hardware. It sometimes
> defaults to a random (even non-BCD) value. This is not an issue
> for handling RTCYEAR register, because bcd2bin() properly handles only
> 8bit values (2 BCD characters, the third one is skipped). The problem
> is however with ALMYEAR register and proper RTC alarm operation. When
> YEAREN bit is set for the configured alarm, RTC hardware triggers alarm
> only when ALMYEAR and RTCYEAR matches. This usually doesn't happen
> because of the random noise on the third BCD character.
> 
> Fix this by simply skipping setting ALMYEAR register in alarm
> configuration. This workaround fixes broken alarm operation on Exynos
> built-in rtc device. My tests revealed that the issue happens on the
> following Exynos series: 3250, 4210, 4412, 5250 and 5410.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
