Return-Path: <SRS0=HMI1=SO=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C995C10F0E
	for <linux-rtc@archiver.kernel.org>; Fri, 12 Apr 2019 08:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E1E204EC
	for <linux-rtc@archiver.kernel.org>; Fri, 12 Apr 2019 08:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfDLIeC (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:34:02 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53467 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfDLIeB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 12 Apr 2019 04:34:01 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 92BE71C0012;
        Fri, 12 Apr 2019 08:33:59 +0000 (UTC)
Date:   Fri, 12 Apr 2019 10:33:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] rtc: mxc: use dev_pm_set_wake_irq() to simplify code
Message-ID: <20190412083359.GQ3578@piout.net>
References: <1554948064-2343-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554948064-2343-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 11/04/2019 02:06:04+0000, Anson Huang wrote:
> With calling dev_pm_set_wake_irq() to set MXC RTC as wakeup source
> for suspend, generic wake irq mechanism will automatically enable
> it as wakeup source when suspend, then the suspend/resume callback
> which are ONLY for enabling/disabling irq wake can be removed, it
> simplifies the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/rtc/rtc-mxc.c | 32 ++++++--------------------------
>  1 file changed, 6 insertions(+), 26 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
