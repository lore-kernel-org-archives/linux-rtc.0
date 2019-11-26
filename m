Return-Path: <SRS0=dL1/=ZS=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CA3C432C0
	for <linux-rtc@archiver.kernel.org>; Tue, 26 Nov 2019 22:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C333206CC
	for <linux-rtc@archiver.kernel.org>; Tue, 26 Nov 2019 22:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfKZWfk (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:35:40 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38515 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfKZWfk (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 26 Nov 2019 17:35:40 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-1-1723-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E8BDF1BF205;
        Tue, 26 Nov 2019 22:35:38 +0000 (UTC)
Date:   Tue, 26 Nov 2019 23:35:38 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     linux-rtc@vger.kernel.org, david.paris@st.com
Subject: Re: [PATCH] rtc: st-lpc: Remove struct resource from struct st_rtc
Message-ID: <20191126223538.GA299836@piout.net>
References: <20191123091241.1905-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123091241.1905-1-nobuhiro1.iwamatsu@toshiba.co.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 23/11/2019 18:12:41+0900, Nobuhiro Iwamatsu wrote:
> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> 
> struct resource in struct st_rtc is not used, remove it.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  drivers/rtc/rtc-st-lpc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
