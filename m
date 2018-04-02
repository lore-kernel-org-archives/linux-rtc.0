Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:55964 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754665AbeDBWvN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 2 Apr 2018 18:51:13 -0400
Received: by mail-wm0-f46.google.com with SMTP id b127so28172870wmf.5
        for <linux-rtc@vger.kernel.org>; Mon, 02 Apr 2018 15:51:13 -0700 (PDT)
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
 <f380bc29-c8dd-5c20-efc4-ffc0ad69b8d6@nexus-software.ie>
 <1522450739.10662.278.camel@impinj.com>
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <4f9434c7-6977-caef-2fac-5da79364304b@nexus-software.ie>
Date: Mon, 2 Apr 2018 23:51:12 +0100
MIME-Version: 1.0
In-Reply-To: <1522450739.10662.278.camel@impinj.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 30/03/18 23:59, Trent Piepho wrote:
> However, I think that even if the driver fails to probe if there is a
> timeout at probe time, it's still possible to hang later if there are
> not limits to the hardware polling loops, such as the ones I added.

I agree with your patch in principle for this the reason you've outlined.

My patch though should still be applied to fix non-starting @ source.

/aside - I don't have your patch in my inbox - if you could resend and 
cc me I'll review it for you.

---
bod
