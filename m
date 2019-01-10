Return-Path: <SRS0=Ax4F=PS=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EB0C43387
	for <linux-rtc@archiver.kernel.org>; Thu, 10 Jan 2019 21:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307E5208E3
	for <linux-rtc@archiver.kernel.org>; Thu, 10 Jan 2019 21:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfAJVDv (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:03:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33289 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbfAJVDv (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 10 Jan 2019 16:03:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E8ADC20898; Thu, 10 Jan 2019 22:03:49 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8627D206DC;
        Thu, 10 Jan 2019 22:03:49 +0100 (CET)
Date:   Thu, 10 Jan 2019 22:03:49 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: Fix UBSAN overflow warning
Message-ID: <20190110210349.GB2362@piout.net>
References: <1545298616-62881-1-git-send-email-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545298616-62881-1-git-send-email-zhangxiaoxu5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 20/12/2018 17:36:56+0800, ZhangXiaoxu wrote:
> Users may call 'ioctl' and pass a very big value on 'tm->tm_year'.
> It can be overflowed in 'int' after add 1900.
> In function 'rtc_month_days' and 'mktime64', also treated it as an
> 'unsigned' parameter.
> 
> UBSAN: Undefined behaviour in drivers/rtc/rtc-lib.c:103:59
> signed integer overflow:
> 2147483647 + 1900 cannot be represented in type 'int'
> 
> UBSAN: Undefined behaviour in drivers/rtc/rtc-lib.c:119:30
> signed integer overflow:
> 2147483647 + 1900 cannot be represented in type 'int'
> 
> So, covert it to 'unsigned' explicitly.
> 
> Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  drivers/rtc/rtc-lib.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
