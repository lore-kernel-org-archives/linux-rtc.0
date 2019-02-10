Return-Path: <SRS0=RSfM=QR=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CD4C282C2
	for <linux-rtc@archiver.kernel.org>; Sun, 10 Feb 2019 21:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D924620855
	for <linux-rtc@archiver.kernel.org>; Sun, 10 Feb 2019 21:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfBJVSx (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 10 Feb 2019 16:18:53 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:51865 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfBJVSx (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 10 Feb 2019 16:18:53 -0500
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 93B81240003;
        Sun, 10 Feb 2019 21:18:51 +0000 (UTC)
Date:   Sun, 10 Feb 2019 22:18:51 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v2] rtc: isl1208: Add new style nvmem support to driver
Message-ID: <20190210211851.GI23062@piout.net>
References: <20190205174139.1383-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205174139.1383-1-tpiepho@impinj.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

On 05/02/2019 17:41:49+0000, Trent Piepho wrote:
> +static const struct nvmem_config isl1208_nvmem_config = {
> +	.name = "isl1208_nvram",
> +	.word_size = 1,
> +	.stride = 1,
> +	/* .size from chip specific config */
> +	.reg_read = isl1208_nvmem_read,
> +	.reg_write = isl1208_nvmem_write,
Can you also set .type here?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
