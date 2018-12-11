Return-Path: <SRS0=kYQR=OU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3129EC5CFFE
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 11:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A6C20811
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 11:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A6C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeLKLQB (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:16:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45366 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKLQB (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 11 Dec 2018 06:16:01 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8C6DF20C4D; Tue, 11 Dec 2018 12:15:59 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6096620717;
        Tue, 11 Dec 2018 12:15:49 +0100 (CET)
Date:   Tue, 11 Dec 2018 12:15:48 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-rtc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 3/5] rtc: pcf85363: Add support for NXP pcf85263 rtc
Message-ID: <20181211111548.GQ8952@piout.net>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
 <1544182066-31528-4-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544182066-31528-4-git-send-email-biju.das@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 07/12/2018 11:27:44+0000, Biju Das wrote:
> Add support for NXP pcf85263 real-time clock. pcf85263 rtc is compatible
> with pcf85363,except that pcf85363 has additional 64 bytes of RAM.
> 
> 1 byte of nvmem is supported and exposed in sysfs (# is the instance
> number,starting with 0): /sys/bus/nvmem/devices/pcf85x63-#/nvmem
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> V1-->V2
> 	* Incorporated Alexandre and Geert's review comment.
> V2-->V3
> 	* Incorporated Geert's review comment.
> V3-->V4
> 	* Incorporated Geert's and Alexandre's review comment.
> ---
>  drivers/rtc/rtc-pcf85363.c | 94 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 76 insertions(+), 18 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
