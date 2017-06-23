Return-Path: <rtc-linux+bncBAABB3VOW3FAKGQEZOSNIJQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from resqmta-po-07v.sys.comcast.net (resqmta-po-07v.sys.comcast.net. [2001:558:fe16:19:96:114:154:166])
        by gmr-mx.google.com with ESMTPS id 16si313538itj.0.2017.06.23.15.34.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 15:34:22 -0700 (PDT)
Reply-To: rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 0/3] rtc: make st-lpc robust against
 y2038/2106 bug
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>, john.stultz@linaro.org,
 tglx@linutronix.de, sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patrice.chotard@st.com,
 a.zummo@towertech.it, linux-arm-kernel@lists.infradead.org,
 rtc-linux@googlegroups.com, linaro-kernel@lists.linaro.org,
 Shuah Khan <shuah@kernel.org>
References: <1497864982-29284-1-git-send-email-benjamin.gaignard@linaro.org>
 <47b45b70-91da-ce41-535d-89d92f380274@kernel.org>
 <20170623220907.kxhkwkl6gt7bho5r@piout.net>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <cea926b2-5d84-18a9-9713-52d1495d550f@kernel.org>
Date: Fri, 23 Jun 2017 16:34:18 -0600
MIME-Version: 1.0
In-Reply-To: <20170623220907.kxhkwkl6gt7bho5r@piout.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

On 06/23/2017 04:09 PM, Alexandre Belloni wrote:
> On 23/06/2017 at 13:40:41 -0600, Shuah Khan wrote:
>> On 06/19/2017 03:36 AM, Benjamin Gaignard wrote:
>>> On 32bits platforms "struct timeval" or "time_t" are using u32 to code the
>>> date, this cause tools like "date" or "hwclock" failed even before setting
>>> the RTC device if the date is superior to year 2038 (or 2106).
>>>
>>> To avoid this problem I add one RTC test file which directly use RTC ioctl
>>> to set and read RTC time and alarm values.
>>> rtctest_setdate allow to set any date/time given in the command line.
>>>
>>> On this version 2 I add check of problematics years in rtctest like suggest
>>> by Alexandre.
>>>
>>> Finally that had allowed me to test and fix rtc-st-lpc driver.
>>>
>>> Benjamin Gaignard (3):
>>>   tools: timer: add rtctest_setdate
>>>   tool: timer: rtctest add check for problematic dates
>>>   rtc: st-lpc: make it robust against y2038/2106 bug
>>>
>>>  drivers/rtc/rtc-st-lpc.c                         |  19 ++--
>>>  tools/testing/selftests/timers/Makefile          |   2 +-
>>>  tools/testing/selftests/timers/rtctest.c         | 121 ++++++++++++++++++++++-
>>>  tools/testing/selftests/timers/rtctest_setdate.c |  86 ++++++++++++++++
>>>  4 files changed, 212 insertions(+), 16 deletions(-)
>>>  create mode 100644 tools/testing/selftests/timers/rtctest_setdate.c
>>>
>>
>> Hi Thomas/John,
>>
>> I can take the first two patches in this series through linux-kselftest
>> with your or John's Ack. Please review and let me know one way or the
>> other.
>>> 
> Well, I'm the maintainer for rtctest.c and I'll make sure to also be the
> one for rtctest_setdate.c> 
>> The third one is a rtc driver patch. Please let me know how do you want
>> to handle this series soon we can get this into 4.13-rc1.
>>
> 
> I'll take the three patches but I still have comment I didn't have time
> to give yet.
> 
> 

Okay. I will drop this off my radar then :)

thanks,
-- Shuah

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
