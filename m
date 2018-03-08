Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755365AbeCHIhM (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Mar 2018 03:37:12 -0500
MIME-Version: 1.0
In-Reply-To: <82561e18-2283-897a-49b9-9606e3b7e1b2@embeddedor.com>
References: <82561e18-2283-897a-49b9-9606e3b7e1b2@embeddedor.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 8 Mar 2018 09:37:10 +0100
Message-ID: <CAJKOXPfx2__Luw9LGevVdBaGL7C3Ldd9uCnBPpUnwgA6U25pKw@mail.gmail.com>
Subject: Re: [RFC] Removing VLAs in rtc-s5m
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Mar 8, 2018 at 4:18 AM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> Hi Alexandre,
>
> I'm trying to figure out the best way to fix the following VLA warnings:
>
> drivers/rtc/rtc-s5m.c:370:2: warning: ISO C90 forbids variable length array
> ‘data’ [-Wvla]
> drivers/rtc/rtc-s5m.c:416:2: warning: ISO C90 forbids variable length array
> ‘data’ [-Wvla]
> drivers/rtc/rtc-s5m.c:453:2: warning: ISO C90 forbids variable length array
> ‘data’ [-Wvla]
> drivers/rtc/rtc-s5m.c:503:2: warning: ISO C90 forbids variable length array
> ‘data’ [-Wvla]
> drivers/rtc/rtc-s5m.c:548:2: warning: ISO C90 forbids variable length array
> ‘data’ [-Wvla]
> drivers/rtc/rtc-s5m.c:601:2: warning: ISO C90 forbids variable length array
> ‘data’ [-Wvla]
>
>
> So I took a look into the following piece of code at
> drivers/rtc/rtc-s5m.c:31, please see my comments below.
>
> /*
>  * Registers used by the driver which are different between chipsets.
>  *
>  * Operations like read time and write alarm/time require updating
>  * specific fields in UDR register. These fields usually are auto-cleared
>  * (with some exceptions).
>  *
>  * Table of operations per device:
>  *
>  * Device     | Write time | Read time | Write alarm
>  * =================================================
>  * S5M8767    | UDR + TIME |           | UDR
>  * S2MPS11/14 | WUDR       | RUDR      | WUDR + RUDR
>  * S2MPS13    | WUDR       | RUDR      | WUDR + AUDR
>  * S2MPS15    | WUDR       | RUDR      | AUDR
>  */
> struct s5m_rtc_reg_config {
>         /* Number of registers used for setting time/alarm0/alarm1 */
>         unsigned int regs_count;
>
>
> Once the maximum number of registers for devices S5M8767, S2MPS11/14 S2MPS13
> and S2MPS15 are 8, 7, 7 and 7 correspondingly, I think we can safely change
> the type of regs_count to u8/uint8_t.

There is no benefit of changing it to u8. You will not get smaller
struct and unsigned int is pretty obvious for counting elements.
Unlike u8.

> And then define a macro like the
> following:
>
> #define MAX_NUM_REGS 8 or 10
>
> so we can replace this kind of code:
>
> u8 data[info->regs->regs_count];
>
> with this:
>
> u8 data[MAX_NUM_REGS];

Yes, 8 makes sense (but name like MAX_NUM_TIME_REGS). I think removing
the additional complexity (and error-prone solution) is worth of
living with wasted one-byte for some of devices. :)

>
> What do you think?
>
> Is there any chance a new device of this kind with more than 10 or 15
> registers can be added in the future?

I think not because Samsung is copying this RTC block from design to
design and just changes few things. More registers would mean that
time and alarms are provided with better precision (milli seconds?
more registers for years?) or with some different calendars. If such
device appears, we can extend the array and accept the waste of
additional bytes. Really, complexity of code is not worth these few
bytes.

Best regards,
Krzysztof
