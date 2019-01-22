Return-Path: <SRS0=37S+=P6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7D7C282C3
	for <linux-rtc@archiver.kernel.org>; Tue, 22 Jan 2019 18:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6E921019
	for <linux-rtc@archiver.kernel.org>; Tue, 22 Jan 2019 18:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfAVSDC (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:03:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45629 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfAVSDC (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 22 Jan 2019 13:03:02 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BE6E7207AB; Tue, 22 Jan 2019 19:02:59 +0100 (CET)
Received: from localhost (unknown [80.12.58.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6BC6920654;
        Tue, 22 Jan 2019 19:02:59 +0100 (CET)
Date:   Tue, 22 Jan 2019 19:02:58 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: fix a missing check of clk_prepare
Message-ID: <20190122180258.GE16702@piout.net>
References: <20181226024333.72236-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226024333.72236-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 25/12/2018 20:43:33-0600, Kangjie Lu wrote:
> clk_prepare() could fail, so let's check its status and if it fails
> return its error code upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/rtc/rtc-coh901331.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
