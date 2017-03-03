Return-Path: <rtc-linux+bncBCJ7RPMX4EMBBQEY47CQKGQE6XM5F3I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wr0-x22e.google.com (mail-wr0-x22e.google.com. [2a00:1450:400c:c0c::22e])
        by gmr-mx.google.com with ESMTPS id h198si336958wmg.1.2017.03.03.12.04.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 12:04:16 -0800 (PST)
Received: by mail-wr0-x22e.google.com with SMTP id g10so80644581wrg.2
        for <rtc-linux@googlegroups.com>; Fri, 03 Mar 2017 12:04:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6e9bb8fa-52e5-0a3a-38b7-57c34bcdfb6b@monstr.eu>
References: <d55404da-fe29-675d-1f3b-008145a6c87b@monstr.eu>
 <20170223121426.i24ssrlwitrvb32h@piout.net> <232e7023-4571-3a91-2366-753a1479c52a@monstr.eu>
 <6e9bb8fa-52e5-0a3a-38b7-57c34bcdfb6b@monstr.eu>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 3 Mar 2017 12:04:15 -0800
Message-ID: <CALAqxLUWD23LWh3z8sr_hFMvrf+SmVOH-i6VHDr60uQZRyWXbA@mail.gmail.com>
Subject: Re: [rtc-linux] RTC used as a module
To: monstr@monstr.eu
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, Mar 3, 2017 at 6:46 AM, Michal Simek <monstr@monstr.eu> wrote:
> Hi Alexandre,
>
> On 3.3.2017 10:41, Michal Simek wrote:
>> Hi Alexandre,
>>
>> On 23.2.2017 13:14, Alexandre Belloni wrote:
>>> Hi Michal,
>>>
>>> I've been thinking about this issue (and meaning to actually test).
>>>
>>> On 08/12/2016 at 14:02:36 +0100, Michal Simek wrote:
>>>> Hi guys,
>>>>
>>>> I am trying to find out reason for this behavior. If rtc-zynqmp is used
>>>> as module for the first time it is correctly probed based on aliases
>>>> setting. (rtc5 for log below). But then driver is removed and add again
>>>> rtc5 is still not freed. rtc_device_release() is not called that's why
>>>> rtc->id can't be used again.
>>>>
>>>> sh-4.3# modprobe rtc-zynqmp
>>>> [   42.468565] rtc_zynqmp ffa60000.rtc: rtc core: registered
>>>> ffa60000.rtc as rtc5
>>>> sh-4.3# rmmod rtc-zynqmp
>>>> sh-4.3# modprobe rtc-zynqmp
>>>> [   48.648222] rtc_zynqmp ffa60000.rtc: /aliases ID 5 not available
>>>> [   48.654280] rtc_zynqmp ffa60000.rtc: rtc core: registered
>>>> ffa60000.rtc as rtc0
>>>>
>>>>
>>>> I didn't try different rtc drivers but it looks like that someone keeps
>>>> reference that's why release function is not called.
>>>>
>>>> Can someone check this with different RTC module?
>>>
>>> I'll do that soon.
>>
>> Have you tried it?
>>
>>>
>>>> Or is this expected behavior?
>>>>
>>>
>>> I don't think so :)
>>>
>>> Can you clarify a few things:
>>>  - is this the only rtc with a driver on your system ?
>>
>> yes only one.
>>
>>>  - is it selected as the RTC_SYSTOHC_DEVICE or RTC_HCTOSYS_DEVICE. I've
>>>    checked the code and I don't think this is the issue but it is worth
>>> testing.
>>
>> This is the setting.
>>
>> CONFIG_RTC_HCTOSYS=y
>> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
>> CONFIG_RTC_SYSTOHC=y
>> CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
>>
>> What I see is that rtc_device_release is not called which is that
>> function which contain ida_simple_remove.
>>
>> I have alias for rtc0 (rtc0 = &rtc;)
>> And here is a log with debug. As you see when driver is removed for the
>> first time rtc_device_release is not called. When this is done for the
>> second time rtc_device_release is called properly and the same device
>> allocated via ida is used.
>>
>> root@linaro-alip:~# dmesg | grep rtc
>> [    3.372715] [drm] Cannot find any crtc or sizes - going 1024x768
>> [    3.422099] hctosys: unable to open rtc device (rtc0)
>> [    6.578930] rtc_zynqmp ffa60000.rtc: rtc core: registered
>> ffa60000.rtc as rtc0
>> root@linaro-alip:~#
>> root@linaro-alip:~# lsmod
>> Module                  Size  Used by
>> rtc_zynqmp             16384  0
>> uio_pdrv_genirq        16384  0
>> root@linaro-alip:~# rmmod rtc_zynqmp
>> [   26.805172] rtc_core: devm_rtc_device_unregister
>> [   26.809794] rtc_core: devm_rtc_device_release
>> [   26.814129] rtc_core: rtc_device_unregister
>> root@linaro-alip:~# modprobe rtc_zynqmp
>> [   35.879655] rtc_zynqmp ffa60000.rtc: /aliases ID 0 not available
>> [   35.886002] rtc_zynqmp ffa60000.rtc: rtc core: registered
>> ffa60000.rtc as rtc1
>> root@linaro-alip:~# rmmod rtc_zynqmp
>> [  122.140487] rtc_core: devm_rtc_device_unregister
>> [  122.145110] rtc_core: devm_rtc_device_release
>> [  122.149443] rtc_core: rtc_device_unregister
>> [  122.153770] rtc_core: rtc_device_release
>> root@linaro-alip:~# modprobe rtc_zynqmp
>> [  123.646002] rtc_zynqmp ffa60000.rtc: /aliases ID 0 not available
>> [  123.652249] rtc_zynqmp ffa60000.rtc: rtc core: registered
>> ffa60000.rtc as rtc1
>> root@linaro-alip:~# rmmod rtc_zynqmp
>> [  125.876188] rtc_core: devm_rtc_device_release
>> [  125.880554] rtc_core: rtc_device_unregister
>> [  125.885163] rtc_core: rtc_device_release
>> root@linaro-alip:~#
>>
>> I have also done experiment to setup rtc alias to rtc1 and this ID is
>> used only once. It looks like something is not released properly.
>>
>> This is out of tree driver but I can't see any specific code which could
>> improve behavior.
>> I have tested i2c rtc mcp79410 and there is not a visible problem but it
>> is not MMIO.
>
> This is the function which is making the difference.
>
> It was added by John Stultz:
> "timers: Introduce in-kernel alarm-timer interface"
> (sha1:  ff3ead96d17f47ee70c294a5cc2cce9b61e82f0f)
>
> Probe function has device_init_wakeup(&pdev->dev, 1);
> That's why reference is taken (get_device() below)
>
> static int alarmtimer_rtc_add_device(struct device *dev,
>                                 struct class_interface *class_intf)
> {
>         unsigned long flags;
>         struct rtc_device *rtc = to_rtc_device(dev);
>
>         if (rtcdev)
>                 return -EBUSY;
>
>         pr_info("%s\n", __func__);
>
>         if (!rtc->ops->set_alarm)
>                 return -1;
>
>         pr_info("%s\n", __func__);
>
>         if (!device_may_wakeup(rtc->dev.parent))
>                 return -1;
>
>         spin_lock_irqsave(&rtcdev_lock, flags);
>         if (!rtcdev) {
>                 rtcdev = rtc;
>                 /* hold a reference so it doesn't go away */
>                 get_device(dev);
>         }
>         spin_unlock_irqrestore(&rtcdev_lock, flags);
>         return 0;
> }
>
> And in remove function device_init_wakeup(&pdev->dev, 0);
> But because there is still a reference rtc_device_release() is not
> called and ida is not freed.
>
> Generic question which I think should be asked if in this situation
> driver should be modular or not.
> If driver can be modular then somewhere should be put_device().

So off the top of my head (sorry, packing for a trip at the moment), I
think this was because the alarmtimer subsystem needs to hold onto the
rtcdev so it doesn't disappear under it, as it will be needed when
setting any alarmtimers on suspend.

Part of the issue is the alarmtimer interface will provide an error to
userspace if there's no rtcdev, so we don't want a situation where
timers successfully set then silently never fire because the rtc was
removed.

That said, there may very well be bugs in how it was handled, and I've
not looked closely at it recently.

thanks
-john

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
