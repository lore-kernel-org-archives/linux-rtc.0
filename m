Return-Path: <rtc-linux+bncBDAMN6NI5EERB5HQQ27QKGQEQBMWYQY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from Galois.linutronix.de (Galois.linutronix.de. [2a01:7a0:2:106d:700::1])
        by gmr-mx.google.com with ESMTPS id 82si1949791wmg.3.2016.09.20.15.30.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 15:30:12 -0700 (PDT)
Date: Wed, 21 Sep 2016 00:27:35 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Baolin Wang <baolin.wang@linaro.org>
cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
    rostedt@goodmis.org, mingo@redhat.com, john.stultz@linaro.org,
    broonie@kernel.org, linux-kernel@vger.kernel.org,
    rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/2] time: alarmtimer: Add the trcepoints for alarmtimer
In-Reply-To: <0d5cedb2f4ad46aa7fb07b990072bacb33517102.1474177609.git.baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.20.1609202340560.5476@nanos>
References: <8c570c152c95087faa75e397c667b6d5b8d98b3b.1474177609.git.baolin.wang@linaro.org> <0d5cedb2f4ad46aa7fb07b990072bacb33517102.1474177609.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, 18 Sep 2016, Baolin Wang wrote:
> +DECLARE_EVENT_CLASS(alarm_setting,

What is alarm_setting? Without looking at the DEFINE_EVENT which uses this
I cannot decode the meaning.

> +	TP_STRUCT__entry(
> +		__field(unsigned char, second)
> +		__field(unsigned char, minute)
> +		__field(unsigned char, hour)
> +		__field(unsigned char, day)
> +		__field(unsigned char, mon)
> +		__field(unsigned short, year)
> +		__field(unsigned char, alarm_type)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->second = rtc_time->tm_sec;
> +		__entry->minute = rtc_time->tm_min;
> +		__entry->hour = rtc_time->tm_hour;
> +		__entry->day = rtc_time->tm_mday;
> +		__entry->mon = rtc_time->tm_mon;
> +		__entry->year = rtc_time->tm_year;
> +		__entry->alarm_type = flag;

What's the value of storing the alarm time in RTC format?

What's wrong with simply storing the flat u64 based wall clock time?
Nothing, because you can do the RTC format conversion in user space.

> +DECLARE_EVENT_CLASS(alarm_processing,

Again alarm_processing is not telling me anything. 

> +
> +	TP_PROTO(struct alarm *alarm, char *process_name),

Why do you want to store process_name? The tracer already tracks the name
of the process in which context the tracepoint is taken. So what's the
point of this? Look at the output:

system_server-2976  [003] d..2  1076.605608: alarmtimer_start: process:system_server

Completely pointless duplicated information.

> +
> +	TP_ARGS(alarm, process_name),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long long, expires)
> +		__field(unsigned char, second)
> +		__field(unsigned char, minute)
> +		__field(unsigned char, hour)
> +		__field(unsigned char, day)
> +		__field(unsigned char, mon)
> +		__field(unsigned short, year)
> +		__field(unsigned char, alarm_type)
> +		__string(name, process_name)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->expires = alarm->node.expires.tv64;
> +		__entry->alarm_type = alarm->type;
> +		__assign_str(name, process_name);
> +		__entry->second = rtc_ktime_to_tm(alarm->node.expires).tm_sec;
> +		__entry->minute = rtc_ktime_to_tm(alarm->node.expires).tm_min;
> +		__entry->hour = rtc_ktime_to_tm(alarm->node.expires).tm_hour;
> +		__entry->day = rtc_ktime_to_tm(alarm->node.expires).tm_mday;
> +		__entry->mon = rtc_ktime_to_tm(alarm->node.expires).tm_mon;
> +		__entry->year = rtc_ktime_to_tm(alarm->node.expires).tm_year;

This is utter crap for various reasons:

1) You store the expiry time over and over and in most cases it's simply
   pointless.

   - If the timer is started then we want to store the expiry time.

   - If the timer fires then the programmed expiry time is available from
     the start trace point and you miss to store the information which is
     really interesting: The actual time at which the timer expires
     (REAL/BOOT)

   - If the timer is canceled then the expiry time in the timer is not
     interesting at all. All you care is about the fact that the timer has
     been canceled. The expiry time can still be retrieved from the start
     trace point.

   - The restart tracepoint is redundant as well because either you see:

     start -> expire -> start or start -> start which is clearly a restart.

     If you put the start trace point into alarmtimer_enqueue() then you
     spare the extra code size for two tracepoints because that is used in
     start and restart

   See the hrtimer and timer tracepoints for reference. 


2) You store the expiry time again in RTC format. Store the information in
   a plain u64 and be done with it.


> +DEFINE_EVENT(alarm_processing, alarmtimer_fired,
> +
> +	TP_PROTO(struct alarm *alarm, char *process_name),

So you hand in a NULL pointer to this tracepoint to have even more useless
information in the trace.

> @@ -264,6 +270,11 @@ static int alarmtimer_suspend(struct device *dev)
>  	now = rtc_tm_to_ktime(tm);
>  	now = ktime_add(now, min);
>  
> +	if (trace_alarmtimer_suspend_enabled()) {

What's the point of this conditional? Avoiding rtc_ktime_to_tm() ? Oh well...

> +		tm_set = rtc_ktime_to_tm(now);
> +		trace_alarmtimer_suspend(&tm_set, type);

"now" is CLOCK_REALTIME based. You store the type of the alarm timer which
is the first to expire and therefor is the one setting the RTC value, but
we don't know which timer it is. Useful - NOT!

Thanks,

	tglx




-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
