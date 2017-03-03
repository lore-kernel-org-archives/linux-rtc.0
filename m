Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBSEO43CQKGQESYA4YYY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v70si256530wmf.0.2017.03.03.07.10.00
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Mar 2017 07:10:00 -0800 (PST)
Date: Fri, 3 Mar 2017 16:09:49 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michal Simek <monstr@monstr.eu>
Cc: John Stultz <john.stultz@linaro.org>, rtc-linux@googlegroups.com,
	Michal Simek <michal.simek@xilinx.com>
Subject: Re: [rtc-linux] RTC used as a module
Message-ID: <20170303150949.qovbx5iifyuquloe@piout.net>
References: <d55404da-fe29-675d-1f3b-008145a6c87b@monstr.eu>
 <20170223121426.i24ssrlwitrvb32h@piout.net>
 <232e7023-4571-3a91-2366-753a1479c52a@monstr.eu>
 <6e9bb8fa-52e5-0a3a-38b7-57c34bcdfb6b@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <6e9bb8fa-52e5-0a3a-38b7-57c34bcdfb6b@monstr.eu>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/03/2017 at 15:46:36 +0100, Michal Simek wrote:
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
> 				struct class_interface *class_intf)
> {
> 	unsigned long flags;
> 	struct rtc_device *rtc = to_rtc_device(dev);
> 
> 	if (rtcdev)
> 		return -EBUSY;
> 
> 	pr_info("%s\n", __func__);
> 
> 	if (!rtc->ops->set_alarm)
> 		return -1;
> 
> 	pr_info("%s\n", __func__);
> 
> 	if (!device_may_wakeup(rtc->dev.parent))
> 		return -1;
> 
> 	spin_lock_irqsave(&rtcdev_lock, flags);
> 	if (!rtcdev) {
> 		rtcdev = rtc;
> 		/* hold a reference so it doesn't go away */
> 		get_device(dev);
> 	}
> 	spin_unlock_irqrestore(&rtcdev_lock, flags);
> 	return 0;
> }
> 
> And in remove function device_init_wakeup(&pdev->dev, 0);
> But because there is still a reference rtc_device_release() is not
> called and ida is not freed.
> 
> Generic question which I think should be asked if in this situation
> driver should be modular or not.
> If driver can be modular then somewhere should be put_device().
> 

>From a quick look, I'd say the issue is coming from
8bc0dafb5cf38a19484dfb16e2c6d29e85820046 which removed the call to
rtc_class_open so you can actually unload the module.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
