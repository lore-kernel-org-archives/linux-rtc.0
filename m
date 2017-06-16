Return-Path: <rtc-linux+bncBAABB3PNR7FAKGQEF5FH7LQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from resqmta-po-12v.sys.comcast.net (resqmta-po-12v.sys.comcast.net. [2001:558:fe16:19:96:114:154:171])
        by gmr-mx.google.com with ESMTPS id z4si192697ita.5.2017.06.16.08.19.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 08:19:09 -0700 (PDT)
Reply-To: rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 0/3] rtc: make st-lpc robust against
 y2038/2106 bug
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>, john.stultz@linaro.org,
 tglx@linutronix.de, sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patrice.chotard@st.com,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com
Cc: linaro-kernel@lists.linaro.org, Shuah Khan <shuah@kernel.org>
References: <1497621833-9942-1-git-send-email-benjamin.gaignard@linaro.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <fe91e845-7218-af8a-16ec-f4c0692e609f@kernel.org>
Date: Fri, 16 Jun 2017 09:19:06 -0600
MIME-Version: 1.0
In-Reply-To: <1497621833-9942-1-git-send-email-benjamin.gaignard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 06/16/2017 08:03 AM, Benjamin Gaignard wrote:
> On 32bits platforms "struct timeval" or "time_t" are using u32 to code the
> date, this cause tools like "date" or "hwclock" failed even before setting
> the RTC device if the date is superior to year 2038 (or 2106).
> 
> To avoid this problem I add two RTC tests files which directly use RTC ioctl
> to set and read RTC time and alarm values.
> rtctest_setdate allow to set any date/time given in the command line.
> rtctest-2038 perform a basic test by writing 1-1-2200 in RTC time and alarm
> and checking that the read back values are correct.
> 
> Finally that had allowed me to test and fix rtc-st-lpc driver.
> 
> Benjamin Gaignard (3):
>   tools: timer: add rtctest_setdate
>   tools: timer: add test to check y2038/2106 bug
>   rtc: st-lpc: make it robust against y2038/2106 bug
> 
>  drivers/rtc/rtc-st-lpc.c                         |  19 ++--
>  tools/testing/selftests/timers/Makefile          |   4 +-
>  tools/testing/selftests/timers/rtctest-2038.c    | 135 +++++++++++++++++++++++
>  tools/testing/selftests/timers/rtctest_setdate.c |  86 +++++++++++++++
>  4 files changed, 232 insertions(+), 12 deletions(-)
>  create mode 100644 tools/testing/selftests/timers/rtctest-2038.c
>  create mode 100644 tools/testing/selftests/timers/rtctest_setdate.c
> 

Hi John/Thomas,

Please review them and let me know. Looks to me these will make good
additions to 4.13-rc1 kselftest content.

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
