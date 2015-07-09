Return-Path: <rtc-linux+bncBAABBCON7KWAKGQEFVJGCRY@googlegroups.com>
Received: from mail.pbx.lv ([213.175.90.140])
        by gmr-mx.google.com with ESMTP id sf5si194424lbb.2.2015.07.09.09.51.21
        for <rtc-linux@googlegroups.com>;
        Thu, 09 Jul 2015 09:51:21 -0700 (PDT)
To: Arnd Bergmann <arnd@arndb.de>
Subject: [rtc-linux] Re: [1/2] RTC: Add core rtc support for Gemini Soc devices
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Date: Thu, 09 Jul 2015 19:51:20 +0300
From: Roman Yeryomin <roman@advem.lv>
Cc: linux-arm-kernel@lists.infradead.org, Felix Fietkau <nbd@openwrt.org>,
 rtc-linux@googlegroups.com, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, Russell King
 <rmk+kernel@arm.linux.org.uk>, Hans Ulli Kroll <ulli.kroll@googlemail.com>
In-Reply-To: <1781580.JRD7b0UrJA@wuerfel>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <2131951.l0j0CIttAZ@wuerfel> <f22e65faa7d86074cda27973f83d7a52@advem.lv>
 <1781580.JRD7b0UrJA@wuerfel>
Message-ID: <89dc8e097d12d9400217a237b7a6ca6e@advem.lv>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 2015-07-09 11:04, Arnd Bergmann wrote:
> On Thursday 09 July 2015 01:29:39 Roman Yeryomin wrote:
>> 
>> OK, here are the minimal changes required (see attachment). Tested on
>> 4.1.1
>> Let me know if you want me to submit it in some other way.
>> 
> 
> The changes look ok to me. Please submit them as two separate
> patches (1. set up and use timer3, 2. register sched_clock) according
> to the Documentation/SubmittingPatches description.
> 

So what do we do?
Do you still want me to split this as you said and submit or you want 
Hans's patches rebased/resubmitted?

Regards,
Roman

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
