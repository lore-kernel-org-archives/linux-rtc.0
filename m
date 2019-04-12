Return-Path: <SRS0=HMI1=SO=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE9EC10F14
	for <linux-rtc@archiver.kernel.org>; Fri, 12 Apr 2019 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1DF2084D
	for <linux-rtc@archiver.kernel.org>; Fri, 12 Apr 2019 08:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfDLIdZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:33:25 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:57105 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfDLIdZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 12 Apr 2019 04:33:25 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 65E8B1C000C;
        Fri, 12 Apr 2019 08:33:23 +0000 (UTC)
Date:   Fri, 12 Apr 2019 10:33:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v1] rtc: rx8025: Fix a parameter to %ptR in
 rx8025_read_alarm()
Message-ID: <20190412083322.GP3578@piout.net>
References: <20190410140559.12909-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410140559.12909-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 10/04/2019 17:05:59+0300, Andy Shevchenko wrote:
> The commit 1921cab11723 ("rtc: rx8025: Switch to use %ptR") converted
> the driver to use new %p extension, but actually used wrong type of
> the parameter in one case.
> 
> Fix a parameter to %ptR in rx8025_read_alarm().
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/rtc/rtc-rx8025.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
