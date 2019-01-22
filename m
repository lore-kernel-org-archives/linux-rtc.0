Return-Path: <SRS0=37S+=P6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D64C282C3
	for <linux-rtc@archiver.kernel.org>; Tue, 22 Jan 2019 16:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C98921726
	for <linux-rtc@archiver.kernel.org>; Tue, 22 Jan 2019 16:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfAVQx6 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:53:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44023 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729233AbfAVQx6 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 22 Jan 2019 11:53:58 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 73DF72078F; Tue, 22 Jan 2019 17:53:56 +0100 (CET)
Received: from localhost (unknown [80.12.58.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 17C86206A6;
        Tue, 22 Jan 2019 17:53:56 +0100 (CET)
Date:   Tue, 22 Jan 2019 17:53:55 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Dianlong Li <long17.cool@163.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] rtc: sd3078: make symbol 'sd3078_driver' static
Message-ID: <20190122165355.GA16702@piout.net>
References: <1547607681-5873-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547607681-5873-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 16/01/2019 03:01:21+0000, Wei Yongjun wrote:
> Fixes the following sparse warning:
> 
> drivers/rtc/rtc-sd3078.c:218:19: warning:
>  symbol 'sd3078_driver' was not declared. Should it be static?
> 
> Fixes: 1d67a232105b ("rtc: sd3078: new driver.")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/rtc/rtc-sd3078.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
