Return-Path: <SRS0=K4ch=UA=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B142C28CC1
	for <linux-rtc@archiver.kernel.org>; Sat,  1 Jun 2019 21:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F0627749
	for <linux-rtc@archiver.kernel.org>; Sat,  1 Jun 2019 21:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfFAVOK (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 1 Jun 2019 17:14:10 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:44749 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfFAVOK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 1 Jun 2019 17:14:10 -0400
X-Originating-IP: 82.246.155.60
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id F260040009;
        Sat,  1 Jun 2019 21:14:05 +0000 (UTC)
Date:   Sat, 1 Jun 2019 23:14:04 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc: tps65910: remove superfluous Kconfig dependency
Message-ID: <20190601211404.GC3558@piout.net>
References: <a7f132a1b8caf779c7c6bd0d43cc907734d287e6.1558775021.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7f132a1b8caf779c7c6bd0d43cc907734d287e6.1558775021.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 25/05/2019 11:12:51+0200, Michał Mirosław wrote:
> TPS65910 entry is already under 'if RTC_CLASS' - remove superfluous
> dependency.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/rtc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
