Return-Path: <SRS0=UNq1=NY=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A86C43441
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Nov 2018 12:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B826B2243E
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Nov 2018 12:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B826B2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbeKMWbX (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:31:23 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50795 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733084AbeKMWbX (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 13 Nov 2018 17:31:23 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7CEDD207F4; Tue, 13 Nov 2018 13:33:25 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 50AE32039F;
        Tue, 13 Nov 2018 13:33:25 +0100 (CET)
Date:   Tue, 13 Nov 2018 13:33:25 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-rtc@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, a.zummo@towertech.it,
        =?utf-8?Q?Bart=C5=82omiej_=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] rtc: s3c-rtc: Avoid using broken ALMYEAR register
Message-ID: <20181113123325.GR29768@piout.net>
References: <CGME20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6@eucas1p1.samsung.com>
 <20181113113250.15527-1-m.szyprowski@samsung.com>
 <CAJKOXPeKOEh9=eNB4FPGUJKykjPQK=6eM69AAw210FRD3SD7qA@mail.gmail.com>
 <333d1f33-11f7-b270-a919-e651143be08d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <333d1f33-11f7-b270-a919-e651143be08d@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 13/11/2018 13:15:33+0100, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2018-11-13 12:50, Krzysztof Kozlowski wrote:
> > On Tue, 13 Nov 2018 at 12:33, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >> (RTC,ALM)YEAR registers of Exynos built-in RTC device contains 3 BCD
> >> characters. s3c-rtc driver uses only 2 lower of them and supports years
> >> from 2000..2099 range. The third BCD value is typically set to 0, but it
> >> looks that handling of it is broken in the hardware. It sometimes
> >> defaults to a random (even non-BCD) value. This is not an issue
> >> for handling RTCYEAR register, because bcd2bin() properly handles only
> >> 8bit values (2 BCD characters, the third one is skipped). The problem
> >> is however with ALMYEAR register and proper RTC alarm operation. When
> >> YEAREN bit is set for the configured alarm, RTC hardware triggers alarm
> >> only when ALMYEAR and RTCYEAR matches. This usually doesn't happen
> >> because of the random noise on the third BCD character.
> >>
> >> Fix this by simply skipping setting ALMYEAR register in alarm
> >> configuration. This workaround fixes broken alarm operation on Exynos
> >> built-in rtc device. My tests revealed that the issue happens on the
> >> following Exynos series: 3250, 4210, 4412, 5250 and 5410.
> > Does it mean that alarm set for 20.11.2019 will be triggered also this
> > year on 20.11.2018 (and any other year as well)?
> Yes, this will trigger one year earlier.
> The question is if this is really and issue in typical use cases...
> 

Note that the core will already set the alarm again if it fired too
early. So this is way better than not firing at all.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
