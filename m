Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:29759 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbdHWTdG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 23 Aug 2017 15:33:06 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sa1100: fix unbalanced clk_prepare_enable/clk_disable_unprepare
References: <20170821160038.22650-1-alexandre.belloni@free-electrons.com>
Date: Wed, 23 Aug 2017 21:33:01 +0200
Message-ID: <87bmn6qdua.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:

> In the error path of sa1100_rtc_open(), info->clk is disabled which will
> happen again in sa1100_rtc_remove() when the module is removed whereas it
> is only enabled once in sa1100_rtc_init().
>
> Fixes: 0cc0c38e9139 ("drivers/rtc/rtc-sa1100.c: move clock enable/disable to probe/remove")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
