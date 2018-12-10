Return-Path: <SRS0=WBM2=OT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A33BC5CFFE
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 23:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0042084C
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 23:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0042084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbeLJXr3 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:47:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58608 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbeLJXr3 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 10 Dec 2018 18:47:29 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AEDB820DC0; Tue, 11 Dec 2018 00:47:26 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 808AB20741;
        Tue, 11 Dec 2018 00:47:16 +0100 (CET)
Date:   Tue, 11 Dec 2018 00:47:16 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Jon Nettleton <jon@solid-run.com>,
        Erik =?utf-8?Q?=C4=8Cuk?= <erik.cuk@domel.com>
Subject: Re: [PATCH] rtc: pcf8523: don't return invalid date when battery is
 low
Message-ID: <20181210234716.GM8952@piout.net>
References: <35660d21e523f535ac959dc9276f61104820f1bf.1544022009.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35660d21e523f535ac959dc9276f61104820f1bf.1544022009.git.baruch@tkos.co.il>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 05/12/2018 17:00:09+0200, Baruch Siach wrote:
> The RTC_VL_READ ioctl reports the low battery condition. Still,
> pcf8523_rtc_read_time() happily returns invalid dates in this case.
> Check the battery health on pcf8523_rtc_read_time() to avoid that.
> 
> Reported-by: Erik Čuk <erik.cuk@domel.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/rtc/rtc-pcf8523.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
