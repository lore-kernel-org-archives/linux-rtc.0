Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:19440 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932433AbdHWTc4 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 23 Aug 2017 15:32:56 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pxa: fix possible race condition
References: <20170821155742.22290-1-alexandre.belloni@free-electrons.com>
Date: Wed, 23 Aug 2017 21:32:54 +0200
Message-ID: <87inheqduh.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:

> pxa_rtc_open() registers the interrupt handler which will access the RTC
> registers. However, pxa_rtc_open() is called before the register range is
> ioremapped. Instead, call it after devm_ioremap().
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
