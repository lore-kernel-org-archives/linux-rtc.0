Return-Path: <SRS0=1ScD=RX=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90485C43381
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 10:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2852186A
	for <linux-rtc@archiver.kernel.org>; Wed, 20 Mar 2019 10:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfCTKie (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:38:34 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:38991 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfCTKid (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 20 Mar 2019 06:38:33 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 94FAC100012;
        Wed, 20 Mar 2019 10:38:30 +0000 (UTC)
Date:   Wed, 20 Mar 2019 11:38:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] rtc: sh: Fix invalid alarm warning for non-enabled alarm
Message-ID: <20190320103827.GO29054@piout.net>
References: <20190320103214.20394-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320103214.20394-1-geert+renesas@glider.be>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 20/03/2019 11:32:14+0100, Geert Uytterhoeven wrote:
> When no alarm has been programmed on RSK-RZA1, an error message is
> printed during boot:
> 
>     rtc rtc0: invalid alarm value: 2019-03-14T255:255:255
> 
> sh_rtc_read_alarm_value() returns 0xff when querying a hardware alarm
> field that is not enabled.  __rtc_read_alarm() validates the received
> alarm values, and fills in missing fields when needed.
> While 0xff is handled fine for the year, month, and day fields, and
> corrected as considered being out-of-range, this is not the case for the
> hour, minute, and second fields, where -1 is expected for missing
> fields.
> 
> Fix this by returning -1 instead, as this value is handled fine for all
> fields.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/rtc/rtc-sh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
