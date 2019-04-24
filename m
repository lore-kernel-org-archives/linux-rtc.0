Return-Path: <SRS0=SQ63=S2=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217FAC10F11
	for <linux-rtc@archiver.kernel.org>; Wed, 24 Apr 2019 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4345218B0
	for <linux-rtc@archiver.kernel.org>; Wed, 24 Apr 2019 15:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfDXP4T (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:56:19 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:55013 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731094AbfDXP4T (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 24 Apr 2019 11:56:19 -0400
Received: from localhost (alyon-652-1-29-238.w109-213.abo.wanadoo.fr [109.213.12.238])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id AB027200016;
        Wed, 24 Apr 2019 15:56:15 +0000 (UTC)
Date:   Wed, 24 Apr 2019 17:56:14 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: stm32: manage the get_irq probe defer case
Message-ID: <20190424155614.GD14604@piout.net>
References: <1556108808-32722-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556108808-32722-1-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 24/04/2019 14:26:48+0200, Fabien Dessenne wrote:
> Manage the -EPROBE_DEFER error case for the wake IRQ.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  drivers/rtc/rtc-stm32.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
