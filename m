Return-Path: <rtc-linux+bncBDKOBWPM5ABRBMVCU65QKGQE4NHJKRY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-yw0-x22f.google.com (mail-yw0-x22f.google.com. [2607:f8b0:4002:c05::22f])
        by gmr-mx.google.com with ESMTPS id z17si782332ywd.4.2016.06.21.16.43.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 16:43:46 -0700 (PDT)
Received: by mail-yw0-x22f.google.com with SMTP id b72so28583530ywa.3
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 16:43:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160621211712.GZ5809@piout.net>
References: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com> <20160621211712.GZ5809@piout.net>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 21 Jun 2016 16:43:45 -0700
Message-ID: <CAHQ1cqGp9kDDWS0bVtTUayQBkKxC1FJNfjURfcjTvX732oauDQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 02/17] RTC: ds1307: Disable square wave and
 timers as default
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jun 21, 2016 at 2:17 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 21/06/2016 at 00:22:35 -0700, Andrey Smirnov wrote :
>> Disable square wave and timers as default for DS1337/39/41 and
>> DS3231. The rationale being that configuring a chip this way puts it
>> into a known state with lower power consumption. While it is not very
>> likely it is still possible that the code controlling RTCs that ran
>> before this driver configured it to produce square wave and left it in
>> such a state.
>>
>
> The main issue being that if it has been configured that way (from the
> bootloader for example). It is probably necessary for the board. There
> may be users of that clock and this patch definitively breaks them.
> The proper way of doing that is to add CCF support in the driver. See:
> http://patchwork.ozlabs.org/patch/576201/

Implementing CCF support would still break users who rely on this
particular behavior and they would still have to spend effort
modifying their boards' device tree blob, so doing it the way you
propose wouldn't really save those users from pain, it would just give
them a way out.

Unfortunately, I don't have a bandwidth to develop and test a feature
that I don't have a use-case for, so I'll drop this patch from v3.

Andrey

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
