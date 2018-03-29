Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:50718 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeC2Bxq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 28 Mar 2018 21:53:46 -0400
Received: by mail-wm0-f45.google.com with SMTP id l201so8020271wmg.0
        for <linux-rtc@vger.kernel.org>; Wed, 28 Mar 2018 18:53:46 -0700 (PDT)
Subject: Re: [RESEND] rtc: snvs: Fix usage of snvs_rtc_enable
To: Trent Piepho <tpiepho@impinj.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "bianpan2016@163.com" <bianpan2016@163.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "guy.shapiro@mobi-wize.com" <guy.shapiro@mobi-wize.com>,
        "Frank.Li@freescale.com" <Frank.Li@freescale.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
References: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
 <1522282337.10662.268.camel@impinj.com>
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <f380bc29-c8dd-5c20-efc4-ffc0ad69b8d6@nexus-software.ie>
Date: Thu, 29 Mar 2018 02:53:44 +0100
MIME-Version: 1.0
In-Reply-To: <1522282337.10662.268.camel@impinj.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 29/03/18 01:12, Trent Piepho wrote:

> I sent a patch a couple weeks ago that addressed a similar issue, see
> https://patchwork.ozlabs.org/patch/887090/
> 
> Does this also fix the problem you see?

It breaks the endless loop that happens later on in the RTC read path.

This patch though is about fixing the bug with not handling the enable 
of the snvs_rtc_enable() correctly, which is why it should be applied.

The right flow is to handle the error on snvs_rtc_enable() as soon as it 
happens as opposed wait for read() to -ETIMEDOUT.

> I think what you've done will prevent the driver from loading if the
> clock is not working, but if the clock does not tick properly after
> loading, there are still points (snvs_rtc_read_time for one) that will
> lock up in the kernel.

I'll dig out your patch and give it a review.

---
bod
