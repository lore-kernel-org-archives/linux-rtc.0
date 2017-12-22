Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.hostpark.net ([212.243.197.30]:49538 "EHLO
        mail.hostpark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdLVNTc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 22 Dec 2017 08:19:32 -0500
Subject: Re: rtc-pcf8563: circular locking dependency
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-rtc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
References: <c8d6a60f-c574-9883-53ea-3b1c55275057@elsoft.ch>
 <20171206101906.GN21780@piout.net>
From: =?UTF-8?Q?David_M=c3=bcller_=28ELSOFT_AG=29?= <d.mueller@elsoft.ch>
Message-ID: <a4d1f4f1-37e9-dbc8-72bf-024c1e4e70df@elsoft.ch>
Date: Fri, 22 Dec 2017 14:19:47 +0100
MIME-Version: 1.0
In-Reply-To: <20171206101906.GN21780@piout.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi

Alexandre Belloni wrote:
> Thanks for the report. This is actually a known issue (at least, I know
> about it).
> 
> I'm adding the clock framework maintainers as this is actually an issue
> that affects any device exposing clocks that are on a bus using clock
> operations in its transfer operations. Here, an i2c RTC, exposing clocks
> and connected on an imx6.
> 
> This has been solved by caching the registers for the m41t80 RTC, see:
> 
> http://patchwork.ozlabs.org/project/rtc-linux/list/?series=11636&state=*
> 
> But, I find that cumbersome and maybe something can be done in the clk
> framework. I didn't check what the prepare_lock protects yet. But maybe
> we can have another lock for get_rate and the like?
> 
> Stephen, Mike, any input?

Any update regarding this issue?


Dave
