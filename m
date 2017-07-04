Return-Path: <rtc-linux+bncBDKNBMNKRMJRBXUC53FAKGQEIOTFH5I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qk0-x233.google.com (mail-qk0-x233.google.com. [2607:f8b0:400d:c09::233])
        by gmr-mx.google.com with ESMTPS id w195si1143761ywa.13.2017.07.04.04.51.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jul 2017 04:51:58 -0700 (PDT)
Received: by mail-qk0-x233.google.com with SMTP id d78so165857232qkb.1
        for <rtc-linux@googlegroups.com>; Tue, 04 Jul 2017 04:51:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cea926b2-5d84-18a9-9713-52d1495d550f@kernel.org>
References: <1497864982-29284-1-git-send-email-benjamin.gaignard@linaro.org>
 <47b45b70-91da-ce41-535d-89d92f380274@kernel.org> <20170623220907.kxhkwkl6gt7bho5r@piout.net>
 <cea926b2-5d84-18a9-9713-52d1495d550f@kernel.org>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 4 Jul 2017 13:51:57 +0200
Message-ID: <CA+M3ks7ybavMZHxJ_sx_H7S6jis+F2Ye0Zi8eE4okY-W-ysbZg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 0/3] rtc: make st-lpc robust against
 y2038/2106 bug
To: shuah@kernel.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, sboyd@codeaurora.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
	patrice.chotard@st.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2017-06-24 0:34 GMT+02:00 Shuah Khan <shuah@kernel.org>:
> Hi Alexandre,
>
> On 06/23/2017 04:09 PM, Alexandre Belloni wrote:
>> On 23/06/2017 at 13:40:41 -0600, Shuah Khan wrote:
>>> On 06/19/2017 03:36 AM, Benjamin Gaignard wrote:
>>>> On 32bits platforms "struct timeval" or "time_t" are using u32 to code the
>>>> date, this cause tools like "date" or "hwclock" failed even before setting
>>>> the RTC device if the date is superior to year 2038 (or 2106).
>>>>
>>>> To avoid this problem I add one RTC test file which directly use RTC ioctl
>>>> to set and read RTC time and alarm values.
>>>> rtctest_setdate allow to set any date/time given in the command line.
>>>>
>>>> On this version 2 I add check of problematics years in rtctest like suggest
>>>> by Alexandre.
>>>>
>>>> Finally that had allowed me to test and fix rtc-st-lpc driver.
>>>>
>>>> Benjamin Gaignard (3):
>>>>   tools: timer: add rtctest_setdate
>>>>   tool: timer: rtctest add check for problematic dates
>>>>   rtc: st-lpc: make it robust against y2038/2106 bug
>>>>
>>>>  drivers/rtc/rtc-st-lpc.c                         |  19 ++--
>>>>  tools/testing/selftests/timers/Makefile          |   2 +-
>>>>  tools/testing/selftests/timers/rtctest.c         | 121 ++++++++++++++++++++++-
>>>>  tools/testing/selftests/timers/rtctest_setdate.c |  86 ++++++++++++++++
>>>>  4 files changed, 212 insertions(+), 16 deletions(-)
>>>>  create mode 100644 tools/testing/selftests/timers/rtctest_setdate.c
>>>>
>>>
>>> Hi Thomas/John,
>>>
>>> I can take the first two patches in this series through linux-kselftest
>>> with your or John's Ack. Please review and let me know one way or the
>>> other.
>>>>
>> Well, I'm the maintainer for rtctest.c and I'll make sure to also be the
>> one for rtctest_setdate.c>
>>> The third one is a rtc driver patch. Please let me know how do you want
>>> to handle this series soon we can get this into 4.13-rc1.
>>>
>>
>> I'll take the three patches but I still have comment I didn't have time
>> to give yet.

Alexandre, may you had time to give me feedback on this ?

Regards,
Benjamin

>>
>>
>
> Okay. I will drop this off my radar then :)
>
> thanks,
> -- Shuah
>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
