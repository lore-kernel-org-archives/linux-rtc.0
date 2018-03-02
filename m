Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:25366 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1423071AbeCBIqw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 2 Mar 2018 03:46:52 -0500
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: RE: [PATCH 000/100] rtc: remove cargo culted code
Date: Fri, 2 Mar 2018 08:46:48 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941570C7@SW-EX-MBX01.diasemi.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Feb 21, 2018 at 8:54 PM, Alexandre Belloni wrote:
 
> subject:	[PATCH 000/100] rtc: remove cargo culted code
> mailing list:	linux-kernel@vger.kernel.org Filter messages from this mailing list
>
> Hello,
>
> This series:
>  - removes useless calls to rtc_valid_tm in .read_time, .set_time and
>    .set_alarm
>  - removes code setting default values for RTCs (and lets the core
>    handle it)
>  - removes useless "time is invalid" messages at probe time
>  - removes useless indirect calls
>
> Those were mostly copy pasted from other drivers

Hi Alexandre,

Acked for:
  rtc: da9063: stop validating rtc_time in .read_time
  rtc: da9052: stop validating rtc_time in .read_time
  rtc: da9055: stop validating rtc_time in .read_time

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Agreed -- rtc_valid_tm() call is cargo cult for the above.

(By definition) for DA9063 I was trying to be rigorous.
The .read_time function is slightly different here because I can make a copy the alarm time into the RTC time
structure to solve an RTC synchronisation problem internally to the DA9063.
https://elixir.bootlin.com/linux/v4.5.6/source/drivers/rtc/rtc-da9063.c#L253

But after some further looking, I have not got any explicit case of how the time read directly from the DA9063
registers can be incorrectly represented. So there should be no need to check this.

Regards,
Steve
