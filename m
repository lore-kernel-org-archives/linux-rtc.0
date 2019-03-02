Return-Path: <SRS0=WPMB=RF=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4270C00319
	for <linux-rtc@archiver.kernel.org>; Sat,  2 Mar 2019 21:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE832087E
	for <linux-rtc@archiver.kernel.org>; Sat,  2 Mar 2019 21:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfCBVHj (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 2 Mar 2019 16:07:39 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51109 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCBVHi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 2 Mar 2019 16:07:38 -0500
X-Originating-IP: 82.246.155.60
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4F77D20002;
        Sat,  2 Mar 2019 21:07:33 +0000 (UTC)
Date:   Sat, 2 Mar 2019 22:07:33 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/5] Add EPSON RX-8571 RTC support
Message-ID: <20190302210733.GC3452@piout.net>
References: <1550742048-28068-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550742048-28068-1-git-send-email-biju.das@bp.renesas.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 21/02/2019 09:40:43+0000, Biju Das wrote:
> This patch set aims to add support for EPSON RX-8571 real-time clock.
> EPSON RX-8571 rtc is compatible with EPSON RX-8581 rtc except that
> former has 16 bytes additional RAM.
> 
> 1 byte of nvmem is supported on both RX-8581 and RX-8571. It is
> exposed through sysfs along with  support for 16 bytes additional RAM
> present only on EPSON RX-8571.
> 
> This patch series is tested against renesas-dev and linux-next.
> 
> Biju Das (5):
>   rtc: rx8581: Add rx8571 compatible
>   rtc: rx8581: Add support for rx8571 RTC
>   rtc: rx8581: Add support for Epson rx8571 RTC

Applied 1-3. Note that I squashed 2 and 3 as 2 didn't make much sense
without 3.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
