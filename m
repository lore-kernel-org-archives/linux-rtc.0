Return-Path: <SRS0=rvRy=QG=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35C0C282D7
	for <linux-rtc@archiver.kernel.org>; Wed, 30 Jan 2019 15:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE8420989
	for <linux-rtc@archiver.kernel.org>; Wed, 30 Jan 2019 15:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfA3PUq (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:20:46 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:40632 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfA3PUq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 30 Jan 2019 10:20:46 -0500
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id AA0BC3A25AA
        for <linux-rtc@vger.kernel.org>; Wed, 30 Jan 2019 16:11:48 +0100 (CET)
Received: from localhost (alyon-652-1-30-254.w109-213.abo.wanadoo.fr [109.213.13.254])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 4027310001C;
        Wed, 30 Jan 2019 15:11:47 +0000 (UTC)
Date:   Wed, 30 Jan 2019 16:11:47 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: abx80x: Configure reserved bits in RV1805
Message-ID: <20190130151147.GI19959@piout.net>
References: <20190129114028.6113-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129114028.6113-1-marex@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 29/01/2019 12:40:28+0100, Marek Vasut wrote:
> The RV1805 uses smaller package than the AB1805, discern those two
> chips based on the compatible value and configure reserved bits in
> the RV1805 to prevent current leakage and accidental test mode entry.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> To: linux-rtc@vger.kernel.org
> ---
>  drivers/rtc/rtc-abx80x.c | 67 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
