Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:50227 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751543AbeDCOmX (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 3 Apr 2018 10:42:23 -0400
Date: Tue, 3 Apr 2018 16:42:11 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Trent Piepho <tpiepho@impinj.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "bianpan2016@163.com" <bianpan2016@163.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "guy.shapiro@mobi-wize.com" <guy.shapiro@mobi-wize.com>,
        "Frank.Li@freescale.com" <Frank.Li@freescale.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: [RESEND] rtc: snvs: Fix usage of snvs_rtc_enable
Message-ID: <20180403144211.GM14180@piout.net>
References: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
 <1522282337.10662.268.camel@impinj.com>
 <f380bc29-c8dd-5c20-efc4-ffc0ad69b8d6@nexus-software.ie>
 <1522450739.10662.278.camel@impinj.com>
 <4f9434c7-6977-caef-2fac-5da79364304b@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4f9434c7-6977-caef-2fac-5da79364304b@nexus-software.ie>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 02/04/2018 at 23:51:12 +0100, Bryan O'Donoghue wrote:
> On 30/03/18 23:59, Trent Piepho wrote:
> > However, I think that even if the driver fails to probe if there is a
> > timeout at probe time, it's still possible to hang later if there are
> > not limits to the hardware polling loops, such as the ones I added.
> 
> I agree with your patch in principle for this the reason you've outlined.
> 
> My patch though should still be applied to fix non-starting @ source.
> 
> /aside - I don't have your patch in my inbox - if you could resend and cc me
> I'll review it for you.
> 

It is available in mbox format here:
http://patchwork.ozlabs.org/patch/887090/mbox/

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
