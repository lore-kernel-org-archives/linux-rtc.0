Return-Path: <rtc-linux+bncBDSYZY5FQMCBBCHN4GZAKGQE4GAPUPA@googlegroups.com>
Received: from mail.cvg.de (mail.cvg.de. [62.153.82.30])
        by gmr-mx.google.com with ESMTPS id g21si294603wmd.3.2015.11.27.07.28.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Nov 2015 07:28:06 -0800 (PST)
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH] rtc-da9063: avoid writing undefined data to rtc
References: <1448625775-15531-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
	<20151127150158.GC4268@piout.net>
Date: Fri, 27 Nov 2015 16:27:25 +0100
In-Reply-To: <20151127150158.GC4268@piout.net> (Alexandre Belloni's message of
	"Fri, 27 Nov 2015 16:01:58 +0100")
Message-ID: <ly1tbbea3m.fsf@ensc-virt.intern.sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: rtc-linux@googlegroups.com
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:

>> | static void da9063_tm_to_data(struct rtc_time *tm, u8 *data,
>> | {
>> |  	const struct da9063_compatible_rtc_regmap *config = rtc->config;
>> |
>> | 	data[RTC_SEC] &= ~config->rtc_count_sec_mask;
>> | 	data[RTC_SEC] |= tm->tm_sec & config->rtc_count_sec_mask;
>> | ...
>> | }
>> ...
>> which means that some bits of stack content (in 'data[]') was masked out
>> and written to the RTC.
>> 
>> Because da9063_tm_to_data() is used only by da9063_rtc_set_time() and
>> da9063_rtc_set_alarm(), we can write fields directly.
>
> Unfortunately, the datasheets are behind a register wall and I can't
> check. Is there any meaningful bits mixed in the date/time registers?

We can set "RTC_EN and CRYSTAL writing disabled" (COUNT_Y[6]) randomly;
this bit has a different meaning for read ("RTC clock okay") and write
("disable writing"; not clearable).

ALARM_MO[4] "Period of the Tick (0: every second, 1: every minute)" or
ALARM_Y[7+6] (enable tick/alarm) should not be set randomly either.


I think, it is always a bad idea to write random data from stack to a
device.


> I think this was intended to keep those bits to their previous value but
> this is not yet implemented.

Datasheet does not say how to deal with "reserved" bits; but it would be
imo overkill to apply a regmap_update_bits() like access to the RTC
registers.


Enrico

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
