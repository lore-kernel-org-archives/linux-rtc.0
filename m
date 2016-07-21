Return-Path: <rtc-linux+bncBD5LPQWS74GBBZWPYS6AKGQE62PXVII@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx1.redhat.com (mx1.redhat.com. [209.132.183.28])
        by gmr-mx.google.com with ESMTPS id r127si725253ywh.0.2016.07.21.12.52.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2016 12:52:05 -0700 (PDT)
Subject: [rtc-linux] Re: __rtc_read_alarm missing month/year field bug?
To: joe.lawrence@redhat.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rtc-linux@googlegroups.com
References: <5768148E.8090304@stratus.com> <57716404.9080204@stratus.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alessandro Zummo <a.zummo@towertech.it>
From: Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <579127E2.9040706@redhat.com>
Date: Thu, 21 Jul 2016 15:52:02 -0400
MIME-Version: 1.0
In-Reply-To: <57716404.9080204@stratus.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/19/2016, Alexandre Belloni wrote:
>
> Well like said in my previous mail, I don't think the rollover is the
> issue here but I'm interested in knowing what conditions are leading >
to endless interrupts.

Hi Alexandre,

Unfortunately I've switched employers so I no longer have access to the
hardware, but if I remember correctly the scenario went like this:

  - boot machine with RTC alarm set in far future
  - run 'hwclock' user program
    - hwclock sync to clock tick
      - RTC_UIE_ON
      - RTC_UIE_OFF
  - kernel sees RTC alarm is outstanding
    - hpet_rtc_interrupt's start streaming in

In the case of this hardware platform, there was a problem with the CMOS
RTC read such that  hpet_rtc_interrupt / rtc_cmos_read believed that the
RTC was busy updating ... that code would delay long enough that the
next HPET rtc interrupt would come in right behind it and choke the CPU
from scheduling anything else.

That platform-specific bug aside, I thought I would report this
strangeness in case it was a real bug -- looks like I didn't fully
consider the rollover case.

-- Joe

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
