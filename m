Return-Path: <SRS0=J01i=5A=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BA8C0044D
	for <linux-rtc@archiver.kernel.org>; Sun, 15 Mar 2020 01:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C122071B
	for <linux-rtc@archiver.kernel.org>; Sun, 15 Mar 2020 01:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgCOBw7 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:52:59 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:41290 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgCOBw7 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 14 Mar 2020 21:52:59 -0400
X-Greylist: delayed 857 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Mar 2020 21:52:58 EDT
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 31E9D3A8B7F;
        Sat, 14 Mar 2020 14:45:26 +0000 (UTC)
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B4AE610000F;
        Sat, 14 Mar 2020 14:45:02 +0000 (UTC)
Date:   Sat, 14 Mar 2020 15:45:02 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] rtc: snvs: Use devm_add_action_or_reset() for calls to
 clk_disable_unprepare()
Message-ID: <20200314144502.GD4518@piout.net>
References: <1584109849-21402-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584109849-21402-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 13/03/2020 22:30:49+0800, Anson Huang wrote:
> Use devm_add_action_or_reset() for calls to clk_disable_unprepare(),
> which can simplify the error handling.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/rtc/rtc-snvs.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
