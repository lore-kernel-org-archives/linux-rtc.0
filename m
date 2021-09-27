Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D93C433FE
	for <linux-rtc@archiver.kernel.org>; Mon, 27 Sep 2021 11:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D98160F6B
	for <linux-rtc@archiver.kernel.org>; Mon, 27 Sep 2021 11:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhI0LSR (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:18:17 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:43843 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhI0LSQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 27 Sep 2021 07:18:16 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EEBC9200009;
        Mon, 27 Sep 2021 11:16:36 +0000 (UTC)
Date:   Mon, 27 Sep 2021 13:16:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     WANG Xuerui <git@xen0n.name>
Cc:     linux-rtc@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH RESEND v5 1/6] rtc: ls2x: Add support for the
 Loongson-2K/LS7A RTC
Message-ID: <YVGoFMLehLhsaoBK@piout.net>
References: <20210823163142.586529-1-git@xen0n.name>
 <20210823163142.586529-2-git@xen0n.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823163142.586529-2-git@xen0n.name>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 24/08/2021 00:31:37+0800, WANG Xuerui wrote:
> +
> +static struct rtc_class_ops ls2x_rtc_ops = {

I forgot to add that this should be const

> +	.read_time = ls2x_rtc_read_time,
> +	.set_time = ls2x_rtc_set_time,
> +};
> +

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
