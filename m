Return-Path: <rtc-linux+bncBDKOBWPM5ABRBY4QU65QKGQEBVUZKPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-yw0-x22a.google.com (mail-yw0-x22a.google.com. [2607:f8b0:4002:c05::22a])
        by gmr-mx.google.com with ESMTPS id h76si1156958ywc.7.2016.06.21.16.06.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 16:06:11 -0700 (PDT)
Received: by mail-yw0-x22a.google.com with SMTP id v77so28010195ywg.0
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 16:06:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160621212238.GA5809@piout.net>
References: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
 <1466493770-11895-12-git-send-email-andrew.smirnov@gmail.com> <20160621212238.GA5809@piout.net>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 21 Jun 2016 16:06:11 -0700
Message-ID: <CAHQ1cqE+Y9iQeZ=nqFdNEa15RyARn54RHG8pO6jh7CLRfqBUnQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 13/17] RTC: ds1307: Report oscillator
 problems more intelligently
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

On Tue, Jun 21, 2016 at 2:22 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 21/06/2016 at 00:22:46 -0700, Andrey Smirnov wrote :
>> Report oscillator problems more intelligently, by printing more
>> information about what cause the issue and not yelling "SET TIME!" at
>> the user.
>>
>
> Well, the proper way of doing that is to ensure that -EINVAL is returned
> when reading the time until it has been set once instead of starting the
> oscillator and forgetting about that useful information.

Agreed, will change in v3.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
