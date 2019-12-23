Return-Path: <SRS0=CyDY=2N=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A670FC2D0C0
	for <linux-rtc@archiver.kernel.org>; Mon, 23 Dec 2019 10:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813D2206B7
	for <linux-rtc@archiver.kernel.org>; Mon, 23 Dec 2019 10:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLWKIE (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:08:04 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:36353 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfLWKIE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 23 Dec 2019 05:08:04 -0500
Received: from localhost (did75-h03-176-184-22-51.dsl.sta.abo.bbox.fr [176.184.22.51])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3D08B200010;
        Mon, 23 Dec 2019 10:08:01 +0000 (UTC)
Date:   Mon, 23 Dec 2019 11:08:00 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: omap: Remove unneeded semicolon
Message-ID: <20191223100800.GB1054858@piout.net>
References: <1576466353-45384-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576466353-45384-1-git-send-email-zhengbin13@huawei.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 16/12/2019 11:19:13+0800, zhengbin wrote:
> Fixes coccicheck warning:
> 
> drivers/rtc/rtc-omap.c:619:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  drivers/rtc/rtc-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
