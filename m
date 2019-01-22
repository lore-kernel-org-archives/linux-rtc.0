Return-Path: <SRS0=37S+=P6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19117C282C3
	for <linux-rtc@archiver.kernel.org>; Tue, 22 Jan 2019 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CE621019
	for <linux-rtc@archiver.kernel.org>; Tue, 22 Jan 2019 17:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfAVRgn (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:36:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45024 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfAVRgn (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 22 Jan 2019 12:36:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BB0C5206A6; Tue, 22 Jan 2019 18:36:41 +0100 (CET)
Received: from localhost (unknown [80.12.58.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 57E5E206A6;
        Tue, 22 Jan 2019 18:36:41 +0100 (CET)
Date:   Tue, 22 Jan 2019 18:36:40 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] rtc: s3c: Use generic helper to get driver data
Message-ID: <20190122173640.GC16702@piout.net>
References: <CGME20190118132845eucas1p2c3e5f6dadb6af90a3701fca03599e094@eucas1p2.samsung.com>
 <20190118132837.15713-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118132837.15713-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 18/01/2019 14:28:37+0100, Marek Szyprowski wrote:
> Replace of_match_node() with of_device_get_match_data(), which removes a
> few lines of code from the driver.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
